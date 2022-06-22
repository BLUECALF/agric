import "package:agric/styles/date_formatter.dart";
import 'dart:convert';
import 'dart:typed_data';
import 'package:agric/database/database.dart';
import 'package:blue_print_pos/blue_print_pos.dart';
import 'package:blue_print_pos/models/models.dart';
import 'package:blue_print_pos/receipt/receipt.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppController extends GetxController
{
  String appname = "Milk Sacco";
  // AUTHRISATION DETAILS

  String username = ""; // holds username of the operator
  String password = ""; // holds password of the operator
  String access_token = "";
  DateTime? current_date = null;
  Map transaction_data = {};



  /// Details for the blueprint printter
  late ReceiptSectionText receiptText ;
  BluePrintPos bluePrintPos = BluePrintPos.instance;
  List<BlueDevice> devices = [];
  var prompt = "".obs;
  String deviceMSG = "";


  Future<List<BlueDevice>> scan_devices()async
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
      width: 300,
    );
    receiptText.addSpacer(useDashed: true); // line with dshes like -------
    receiptText.addText(data["company"], size: ReceiptTextSizeType.extraLarge, style: ReceiptTextStyleType.bold,alignment: ReceiptAlignment.center);
    receiptText.addText(data["address"], size: ReceiptTextSizeType.large, style: ReceiptTextStyleType.normal , alignment: ReceiptAlignment.center);
    receiptText.addText(data["country"], size: ReceiptTextSizeType.large, style: ReceiptTextStyleType.bold ,alignment: ReceiptAlignment.center);
    receiptText.addText(data["email"], size: ReceiptTextSizeType.large, style: ReceiptTextStyleType.normal , alignment: ReceiptAlignment.center);
    receiptText.addText(data["phone"], size: ReceiptTextSizeType.large, style: ReceiptTextStyleType.normal ,alignment: ReceiptAlignment.center);

    receiptText.addSpacer(useDashed: true); // line with dshes like -------
    receiptText.addSpacer(useDashed: true);
    receiptText.addText(data["current_transaction"]["transaction_type"], size: ReceiptTextSizeType.extraLarge, style: ReceiptTextStyleType.bold , alignment: ReceiptAlignment.center);
    receiptText.addSpacer();
    var l = ReceiptTextSizeType.large;
    receiptText.addLeftRightText("Date", getDateString(data["current_transaction"]["date"]),leftSize: l,rightSize: l);
    receiptText.addSpacer();
    receiptText.addLeftRightText("Time", getFormattedTime(data["current_transaction"]["date"]),leftSize: l,rightSize: l);
    receiptText.addSpacer();
    receiptText.addLeftRightText("Id", data["current_transaction"]["id"].toString(),leftSize: l,rightSize: l);
    receiptText.addSpacer();
    receiptText.addLeftRightText("Product", data["current_transaction"]["product"],leftSize: l,rightSize: l);
    receiptText.addSpacer();
    receiptText.addLeftRightText("Farmer Number", data["current_transaction"]["farmer_number"],leftSize: l,rightSize: l);
    receiptText.addSpacer();
    receiptText.addLeftRightText("Amount KG", data["current_transaction"]["amount_kg"].toString(),leftSize: l,rightSize: l);
    receiptText.addSpacer();
    receiptText.addLeftRightText("Served By", data["current_transaction"]["username"],leftSize: l,rightSize: l);

    receiptText.addSpacer(useDashed: true); // line with dshes like -------
    receiptText.addText("NET TOTAL", size: ReceiptTextSizeType.extraLarge, style: ReceiptTextStyleType.bold ,alignment: ReceiptAlignment.center);
    receiptText.addSpacer();
    receiptText.addText("FARMER SOLD TO US :", size: ReceiptTextSizeType.large, style: ReceiptTextStyleType.normal ,alignment: ReceiptAlignment.left);

    for(int i = 0; i < data["total_purchase_list"].length ; i++)
      {
        receiptText.addSpacer();
        receiptText.addLeftRightText(data["total_purchase_list"][i].product,"${data["total_purchase_list"][i].amount_kg} KGS",leftSize: l,rightSize: l);
      }
    receiptText.addSpacer(useDashed: true);
/*    receiptText.addText("FARMER PURCHASED FROM US :", size: ReceiptTextSizeType.large, style: ReceiptTextStyleType.normal ,alignment: ReceiptAlignment.left);

    for(int i = 0; i < data["total_sale_list"].length ; i++)
    {
      receiptText.addSpacer();
      receiptText.addLeftRightText(data["total_sale_list"][i].product,"${data["total_sale_list"][i].amount_kg} KGS",leftSize: l,rightSize: l);
    }*/
    receiptText.addText("Farmers best Friend", size: ReceiptTextSizeType.large, style: ReceiptTextStyleType.bold ,alignment: ReceiptAlignment.center);
    receiptText.addText("Thank You, please come again ", size: ReceiptTextSizeType.large, style: ReceiptTextStyleType.bold ,alignment: ReceiptAlignment.center);

  }
  Future<ReceiptSectionText> prepare_xreport_receipt(Xreport x) async
  {
    var  receiptText = ReceiptSectionText();
    // prepare logo
    final ByteData logoBytes = await rootBundle.load("assets/cow_w_mlk.png");
    receiptText.addImage(
      base64.encode(Uint8List.view(logoBytes.buffer)),
      width: 300,
    );
    var l = ReceiptTextSizeType.large;
    var b = ReceiptTextStyleType.bold;

    receiptText.addSpacer(useDashed: true); // line with dshes like -------
    receiptText.addText("Agric Sacco", size: ReceiptTextSizeType.extraLarge, style: ReceiptTextStyleType.bold,alignment: ReceiptAlignment.center);
    receiptText.addText("123 road", size: ReceiptTextSizeType.large, style: ReceiptTextStyleType.normal , alignment: ReceiptAlignment.center);
    receiptText.addText("Olenguruone", size: ReceiptTextSizeType.large, style: ReceiptTextStyleType.bold ,alignment: ReceiptAlignment.center);
    receiptText.addSpacer();
    receiptText.addText("X Report", size: ReceiptTextSizeType.large, style: ReceiptTextStyleType.normal , alignment: ReceiptAlignment.center);
    receiptText.addLeftRightText("Date", getDateString(DateTime.now()),leftSize: l,rightSize: l);
    receiptText.addSpacer();
    receiptText.addLeftRightText("Time", getFormattedTime(DateTime.now()),leftSize: l,rightSize: l);
    receiptText.addSpacer();
    receiptText.addLeftRightText("Transactions Sold", x.transactions_sold.toString(),leftSize: l,rightSize: l);
    receiptText.addSpacer();
    receiptText.addLeftRightText("Transactions Bought", x.transactions_bought.toString(),leftSize: l,rightSize: l);
    receiptText.addSpacer();
    receiptText.addLeftRightText("Units sold", x.units_sold.toString(),leftSize: l,rightSize: l);
    receiptText.addSpacer();
    receiptText.addLeftRightText("Units bought", x.units_bought.toString(),leftSize: l,rightSize: l);
    receiptText.addSpacer(count: 2);
    receiptText.addLeftRightText("Printed by", username,leftSize: l,rightSize: l,leftStyle: b,rightStyle: b);
    receiptText.addSpacer(count: 4);
    return receiptText;
  }
  Future<ReceiptSectionText> prepare_zreport_receipt(Zreport z) async
  {
    var  receiptText = ReceiptSectionText();
    // prepare logo
    final ByteData logoBytes = await rootBundle.load("assets/cow_w_mlk.png");
    receiptText.addImage(
      base64.encode(Uint8List.view(logoBytes.buffer)),
      width: 300,
    );
    var l = ReceiptTextSizeType.large;
    var b = ReceiptTextStyleType.bold;

    receiptText.addSpacer(useDashed: true); // line with dshes like -------
    receiptText.addText("Agric Sacco", size: ReceiptTextSizeType.extraLarge, style: ReceiptTextStyleType.bold,alignment: ReceiptAlignment.center);
    receiptText.addText("123 road", size: ReceiptTextSizeType.large, style: ReceiptTextStyleType.normal , alignment: ReceiptAlignment.center);
    receiptText.addText("Olenguruone", size: ReceiptTextSizeType.large, style: ReceiptTextStyleType.bold ,alignment: ReceiptAlignment.center);
    receiptText.addSpacer();
    receiptText.addText("Z Report", size: ReceiptTextSizeType.large, style: ReceiptTextStyleType.normal , alignment: ReceiptAlignment.center);

    receiptText.addLeftRightText("ID ", z.zreport_id.toString(),leftSize: l,rightSize: l);
    receiptText.addSpacer();
    receiptText.addLeftRightText("Date", getDateString(z.date),leftSize: l,rightSize: l);
    receiptText.addSpacer();
    receiptText.addLeftRightText("Time", getFormattedTime(z.date),leftSize: l,rightSize: l);
    receiptText.addSpacer();
    receiptText.addLeftRightText("Transactions Sold", z.transactions_sold.toString(),leftSize: l,rightSize: l);
    receiptText.addSpacer();
    receiptText.addLeftRightText("Transactions Bought", z.transactions_bought.toString(),leftSize: l,rightSize: l);
    receiptText.addSpacer();
    receiptText.addLeftRightText("Units sold", z.units_sold.toString(),leftSize: l,rightSize: l);
    receiptText.addSpacer();
    receiptText.addLeftRightText("Units bought", z.units_bought.toString(),leftSize: l,rightSize: l);
    receiptText.addSpacer(count: 2);
    receiptText.addLeftRightText("Printed by", username,leftSize: l,rightSize: l,leftStyle: b,rightStyle: b);
    receiptText.addSpacer(count: 4);
    return receiptText;
  }

}