

import 'package:agric/database/database.dart';
import 'package:agric/pages/controller/reports_controller.dart';
import 'package:agric/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ReportsScreen extends GetView{

  final ReportsController reportsController = Get.put(ReportsController());
  @override
  Widget build(BuildContext context) {

    reportsController.get_objects();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        elevation: 0,
      ),
      backgroundColor: Colors.greenAccent,
      body: SafeArea(
        child:SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Z report List",style: MyTextStyle.make("title"),),
                SizedBox(height: 20,),
                FutureBuilder(future : reportsController.database.getZreportList(reportsController.appController.username),
                    builder: (context, snapshot)
                {
                  reportsController.zreportList = snapshot.data as List<Zreport>;
                  return  DataTable(
                      columns: [
                        DataColumn(label: Text("Date")),
                        DataColumn(label: Text("Transactions Sold")),
                        DataColumn(label: Text("Units Sold")),
                        DataColumn(label: Text("Transactions Bought")),
                        DataColumn(label: Text("Units Bought")),
                        DataColumn(label: Text("User Name")),
                        DataColumn(label: Text("View Detailed")),
                      ],

                      rows: reportsController.zreportList.map((e) => reportsController.makedatarow_of_zreport(e)).toList());

                }),
              ],
            ),
          ),
        ),
        ),
      );


  }
}
