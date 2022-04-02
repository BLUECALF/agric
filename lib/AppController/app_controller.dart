
import 'dart:convert';
import 'dart:typed_data';

import 'package:blue_print_pos/blue_print_pos.dart';
import 'package:blue_print_pos/models/models.dart';
import 'package:blue_print_pos/receipt/receipt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppController extends GetxController
{

  String username = ""; // holds username of the operator
  DateTime? current_date = null;
  Map transaction_data = {};

  /// Details for the blueprint printter
  late ReceiptSectionText receiptText ;
  BluePrintPos bluePrintPos = BluePrintPos.instance;
  List<BlueDevice> devices = [];
  var prompt = "".obs;
  String deviceMSG = "";


  Future<List<BlueDevice>> scann_devices()async
  {
    devices = await bluePrintPos.scan();
    return devices;
  }
// FUNCION TO PREPARE TXT BEFORE PRINTING

  Future<void> prepare_text(Map<String,dynamic> data) async
  {
    /// FEILDS NEEDED TO BE CAPTURED
  /*  "logo":"assets/fresh_milk.jpg",
  "company":"Agric Sacco",
  "address":"PO BOX 67,Olenguruone",
  "country":"Kenya",
  "email" : "info@agricsacco.com",
  "phone" : "+254741942765",
  "current_transaction":previous_data,
  "total_sales":total_sale_list,
  "total_purchase":total_purchase_list,*/

    receiptText = ReceiptSectionText();
   // prepare logo
    final ByteData logoBytes = await rootBundle.load(data["logo"]);
    receiptText.addImage(
      base64.encode(Uint8List.view(logoBytes.buffer)),
      width: 50,
    );
    receiptText.addSpacer(useDashed: true); // line with dshes like -------
    receiptText.addText(data["company"], size: ReceiptTextSizeType.large, style: ReceiptTextStyleType.bold,alignment: ReceiptAlignment.center);
    receiptText.addSpacer();
    receiptText.addText(data["address"], size: ReceiptTextSizeType.medium, style: ReceiptTextStyleType.normal , alignment: ReceiptAlignment.left);
    receiptText.addSpacer();
    receiptText.addText(data["country"], size: ReceiptTextSizeType.medium, style: ReceiptTextStyleType.bold ,alignment: ReceiptAlignment.left);
    receiptText.addSpacer();
    receiptText.addText(data["email"], size: ReceiptTextSizeType.medium, style: ReceiptTextStyleType.normal , alignment: ReceiptAlignment.left);
    receiptText.addSpacer();
    receiptText.addText(data["phone"], size: ReceiptTextSizeType.medium, style: ReceiptTextStyleType.normal ,alignment: ReceiptAlignment.left);
    receiptText.addSpacer(useDashed: true); // line with dshes like -------
    receiptText.addText(data["current_transaction"]["transaction_type"], size: ReceiptTextSizeType.medium, style: ReceiptTextStyleType.normal , alignment: ReceiptAlignment.center);
    receiptText.addSpacer();
    receiptText.addLeftRightText("Id", data["current_transaction"]["id"].toString());
    receiptText.addSpacer();
    receiptText.addLeftRightText("Product", data["current_transaction"]["product"]);
    receiptText.addSpacer();
    receiptText.addLeftRightText("Farmer Number", data["current_transaction"]["farmer_number"]);
    receiptText.addSpacer();
    receiptText.addLeftRightText("Amount KG", data["current_transaction"]["amount_kg"].toString());
    receiptText.addSpacer();
    receiptText.addLeftRightText("Served By", data["current_transaction"]["username"]);

    receiptText.addSpacer(useDashed: true); // line with dshes like -------
    receiptText.addText("NET TOTAL", size: ReceiptTextSizeType.medium, style: ReceiptTextStyleType.normal ,alignment: ReceiptAlignment.center);
    receiptText.addSpacer();
    receiptText.addText("FARMER SOLD TO US :", size: ReceiptTextSizeType.medium, style: ReceiptTextStyleType.normal ,alignment: ReceiptAlignment.left);

    for(int i = 0; i < data["total_purchase_list"].length ; i++)
      {
        receiptText.addSpacer();
        receiptText.addLeftRightText(data["total_purchase_list"][i].product,"${data["total_purchase_list"][i].amount_kg} KGS");
      }
    receiptText.addSpacer(useDashed: true);
    receiptText.addText("FARMER PURCHASED FROM US :", size: ReceiptTextSizeType.medium, style: ReceiptTextStyleType.normal ,alignment: ReceiptAlignment.left);

    for(int i = 0; i < data["total_sale_list"].length ; i++)
    {
      receiptText.addSpacer();
      receiptText.addLeftRightText(data["total_sale_list"][i].product,"${data["total_sale_list"][i].amount_kg} KGS");
    }
    receiptText.addSpacer();
    receiptText.addSpacer();
    receiptText.addSpacer();
    receiptText.addSpacer();
    receiptText.addText("Farmers best Friend", size: ReceiptTextSizeType.medium, style: ReceiptTextStyleType.bold ,alignment: ReceiptAlignment.center);
    receiptText.addSpacer();
    receiptText.addText("Thank You, please come again ", size: ReceiptTextSizeType.medium, style: ReceiptTextStyleType.bold ,alignment: ReceiptAlignment.center);

  }

}