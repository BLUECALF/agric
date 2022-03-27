
import 'package:agric/AppController/app_controller.dart';
import 'package:agric/database/database.dart';
import 'package:agric/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailedReportController extends GetxController
{
  late int zreport_id;
  late AppController appController = Get.find<AppController>();
  late AppDatabase database  = Get.find<AppDatabase>();
  final SalesDao salesDao = Get.find<SalesDao>();
  List<Sale> salesList =[];
  List<Purchase> purchaseList=[];

  get_data_from_previous_screen()
  {
    zreport_id = Get.arguments["zreport_id"];
  }


  // get data from db
  get_objects() async
  {
    salesList = await salesDao.getSaleList_by_zreport_id(zreport_id);
    purchaseList = await database.getPurchaseList_by_zreport_id(zreport_id);
    // after we get values we recall build by update

    print("PURCHASE  DATA IS \n\n ${purchaseList}");
    print("SALE  DATA IS \n\n ${salesList}");
  }
  /// make row of SALES
  Widget makerow_of_sales(Sale sale)
  {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(child: Text("${sale.product}"),decoration: BoxDecoration(
            color: Colors.grey,
          ),),
        ),
        Expanded(
          flex: 1,
          child: Container(child: Text("${sale.farmer_number}"),decoration: BoxDecoration(
            color: Colors.grey[400],
          ),),
        ),
        Expanded(
          flex: 1,
          child: Container(child: Text("${sale.amount_kg}"),decoration: BoxDecoration(
            color: Colors.grey[300],
          ),),
        ),

      ],

    );
  }
  /// make ro of PURCHASE
  Widget makerow_of_purchase(Purchase purchase)
  {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(child: Text("${purchase.product}"),decoration: BoxDecoration(
            color: Colors.grey,
          ),),
        ),
        Expanded(
          flex: 1,
          child: Container(child: Text("${purchase.farmer_number}"),decoration: BoxDecoration(
            color: Colors.grey[400],
          ),),
        ),
        Expanded(
          flex: 1,
          child: Container(child: Text("${purchase.amount_kg}"),decoration: BoxDecoration(
            color: Colors.grey[300],
          ),),
        ),
      ],

    );
  }

}