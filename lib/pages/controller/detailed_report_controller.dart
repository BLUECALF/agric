
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

  DataRow makedatarow_of_sales(Sale s) {
    var full_date =  s.date;
    final _dayFormater = DateFormat('d');
    final _monthFormater = DateFormat('M');
    final _yearFormater = DateFormat('y');

    var date = "${_dayFormater.format(full_date)}-${_monthFormater.format(full_date)}-${_yearFormater.format(full_date)}";
    return DataRow(
        cells: [
          DataCell(Text("${s.id}")),
          DataCell(Text("${date}")),
          DataCell(Text("${s.product}")),
          DataCell(Text("${s.amount_kg}")),
          DataCell(Text("${s.farmer_number}")),
          DataCell(Text("${s.username}")),

        ]);
  }

  DataRow makedatarow_of_purchases(Purchase s) {
    var full_date =  s.date;
    final _dayFormater = DateFormat('d');
    final _monthFormater = DateFormat('M');
    final _yearFormater = DateFormat('y');

    var date = "${_dayFormater.format(full_date)}-${_monthFormater.format(full_date)}-${_yearFormater.format(full_date)}";
    return DataRow(
        cells: [
          DataCell(Text("${s.id}")),
          DataCell(Text("${date}")),
          DataCell(Text("${s.product}")),
          DataCell(Text("${s.amount_kg}")),
          DataCell(Text("${s.farmer_number}")),
          DataCell(Text("${s.username}")),

        ]);
  }

}