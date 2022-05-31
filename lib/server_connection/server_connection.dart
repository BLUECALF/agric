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
  postPurchase() async
  {
    var headers = {
      'Authorization': 'Bearer ${appController.access_token}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://agric.dev.ol-digital.com/rest/v2/services/saccoman_RestService/postSaleEntry'));
    request.body = json.encode({
      "entry": {
        "farmerAccount": "1006",
        "amount": 17
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var resp_str = await response.stream.bytesToString();
      print("resp_str: ${resp_str}");
      if (resp_str== "OK")
      {Get.defaultDialog(title:"Notice"
          , textConfirm: "ok",content: Text("Purchase recorded successfully"),
          onConfirm: (){Get.back();Get.back();}
      );}
      else{
      Get.defaultDialog(title:"Notice"
          , textConfirm: "ok",content: Text("Failed : ${resp_str}"),
          onConfirm: (){Get.back();Get.back();}
      );}
  }
  else {
  print(response.reasonPhrase);
  Get.defaultDialog(title:"Notice"
      , textConfirm: "ok",content: Text("Purchase upload failed"),
      onConfirm: (){Get.back();Get.back();}
  );
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