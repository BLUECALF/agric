
import 'package:agric/database/database.dart';
import 'package:agric/pages/views/trade_screen.dart';
import 'package:agric/styles/text_style.dart';
import 'package:blue_print_pos/receipt/receipt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../AppController/app_controller.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils.dart';

class PrintingController extends GetxController
{
  final AppController appController = Get.find<AppController>();
  final AppDatabase database = Get.find<AppDatabase>();
  Map previous_data ={};
  late String farmer_number;
  late Map<String, dynamic> data;

  // what i need to make the recipt
  late String transaction_type;
  late Sale current_sale ;
  late Purchase current_purchase;
  late String merchant;
  late String farmer_name;
  late String action;
  var transaction_object;
  late List<TotalSale> total_sale_list=[];
  late Map<String,dynamic> current_transaction;

  late List<TotalPurchase> total_purchase_list=[];

  void get_data_from_confirm_screen(Map data)
  {
    print(" data from Confirm screen r ${Get.arguments}");
   previous_data =  data;
   transaction_object = previous_data["transaction_object"];
   merchant = previous_data["merchant"];
   farmer_name = previous_data["farmer_name"];
   action = previous_data["action"];


   if(action == "sell_product")
   {
     current_sale = previous_data["transaction_object"];
     farmer_number = current_sale.farmer_number;
     transaction_type = "Sale";
   }else
   {
     current_purchase = previous_data["transaction_object"];
     farmer_number = current_purchase.farmer_number;
     transaction_type = "Purchase";
   }

  }

  // show transaction details
  String show_transaction_details(String action)
  {
    if(action=="sell_product")
    {
      String details = "${transaction_type} \n"
          "${transaction_type} ID : ${current_sale.id} \n"
          "Product : ${current_sale.product} \n"
          "Farmer number : ${current_sale.farmer_number} \n"
          "Amount in KG :${current_sale.amount_kg}";

      current_transaction =
      {
        "transaction_type":transaction_type,
        "id": current_sale.id,
        "date":current_sale.date,
        "product" : current_sale.product,
        "farmer_number":current_sale.farmer_number,
        "farmer_name":farmer_name,
        "username":current_sale.username,
        "amount_kg":current_sale.amount_kg
      };


      return details;
    }
    if(action=="buy_product")
    {

      String details =
          "${transaction_type} \n"
          "${transaction_type} ID : ${current_purchase.id} "
          "\n""Product : ${current_purchase.product} \n"
          "Farmer number : ${current_purchase.farmer_number} \n"
          "Amount in KG :${current_purchase.amount_kg}";
      current_transaction =
      {
        "transaction_type":transaction_type,
        "id": current_purchase.id,
        "date":current_purchase.date,
        "product" : current_purchase.product,
        "farmer_number":current_purchase.farmer_number,
        "farmer_name":farmer_name,
        "username":current_purchase.username,
        "amount_kg":current_purchase.amount_kg
      };
      return details;
    }
    return "";
  }

  Future<void> get_totals_from_database() async
  {
    total_purchase_list = await database.getTotalPurchaseList_of_farmer_number(farmer_number);
    total_sale_list = await database.getTotalSaleList_of_farmer_number(farmer_number);
  }


  void on_press_print() async
  {

    // make a map containing everything in recipt
    data  = {
      "logo":"assets/fresh_milk.jpg",
      "company":"Agric Sacco",
      "address":"PO BOX 67,Olenguruone",
      "country":"Kenya",
      "email" : "info@agricsacco.com",
      "phone" : "+254741942765",
      "current_transaction":current_transaction,
      "total_sale_list":total_sale_list,
      "total_purchase_list":total_purchase_list,
    };

    await appController.bluePrintPos.printReceiptText(ReceiptSectionText());
    await appController.prepare_text(data);
    await appController.bluePrintPos.printReceiptText(
        appController.receiptText, feedCount: 0
    );
    await appController.bluePrintPos.printQR(data["current_transaction"]["id"].toString(), useCut: false);
    await appController.bluePrintPos.printReceiptText(ReceiptSectionText()..addSpacer(count: 3));

    Get.back();
    Get.back();
    Get.off(TradeScreen());

  }
}
