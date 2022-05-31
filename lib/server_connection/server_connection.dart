import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:agric/database/database.dart';
import 'package:agric/AppController/app_controller.dart';

class ServerConnection extends GetxController
{
  final database = Get.find<AppDatabase>();
  final appController = Get.find<AppController>();
  Future<bool> connect_to_server() async
  {
    var headers = {
      'Authorization': 'Basic c2FjY29tYW4tOWlSeWYyMTQ6MTE4MDYwY2U4ODg1OGVlMjM5NmMxZWVhMzMzMDE5MTE5ZjVhNjVmNjUyMWYzMjlmMjg0MzkwNTJkYmY4Y2ViYQ==',
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('POST', Uri.parse('https://agric.dev.ol-digital.com/rest/v2/oauth/token'));
    request.bodyFields = {
      'grant_type': 'password',
      'username': appController.username,
      'password': appController.password,
    };
    request.headers.addAll(headers);

    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      print(response.body);
      Map body_data = jsonDecode(response.body);
      appController.access_token = body_data["access_token"];
      print(appController.access_token);
      /*Get.defaultDialog(title:"Notice"
          , textConfirm: "ok",content: Text("Connected to server"),
          onConfirm: (){Get.back();Get.back();}
      );*/
      return true;
    }
    else {
      print(response.reasonPhrase);
     /* Get.defaultDialog(title:"Notice"
          , textConfirm: "ok",content: Text("Connection Failed"),
          onConfirm: (){Get.back();Get.back();}
      );*/
      return false;
    }
  }
  Future<void> postPurchase() async
  {
    List<Purchase> purchaseList = await database.getPurchaseList_by_username(appController.username);
print(purchaseList);
    var headers = {
      'Authorization': 'Bearer ${appController.access_token}',
      'Content-Type': 'application/json'
    };

    for(int i = 0; i < purchaseList.length;i++)
      {
        Purchase p = purchaseList[i];
        if(p.uploaded == null|| p.uploaded == false)
          {
            // we upload it.
            var request = http.Request('POST', Uri.parse('https://agric.dev.ol-digital.com/rest/v2/services/saccoman_RestService/postSaleEntry'));
            request.body = json.encode({
              "entry": {
                "farmerAccount": p.farmer_number,
                "amount": p.amount_kg
              }
            });
            request.headers.addAll(headers);

            http.StreamedResponse response = await request.send();

            if (response.statusCode == 200) {
              // it was uploaded successfully .. update record
              print("purchase uploaded");
              await database.updatePurchase(
                  Purchase(id: p.id, date: p.date,
                      product: p.product, amount_kg: p.amount_kg, farmer_number: p.farmer_number,
                      username: p.username,uploaded: true));
          }
      }
  }

  }

  Future<List> getFarmersList() async
  {
    var headers = {
      'Authorization': 'Bearer ${appController.access_token}'
    };
    var request = http.Request('POST', Uri.parse('https://agric.dev.ol-digital.com/rest/v2/services/saccoman_RestService/getFarmerAccount'));

    request.headers.addAll(headers);

    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      List<dynamic> farmersList = jsonDecode(response.body);
      print(farmersList);
      return farmersList;
  }
  else {
  print(response.reasonPhrase);
  return [];
  }
  }


}