

import 'package:agric/database/database.dart';
import 'package:agric/pages/controller/detailed_report_controller.dart';
import 'package:agric/pages/controller/reports_controller.dart';
import 'package:agric/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DetailedReportsScreen extends GetView{

  final DetailedReportController detailedReportController = Get.put(DetailedReportController());
  @override
  Widget build(BuildContext context) {
    detailedReportController.get_data_from_previous_screen();

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
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20,50,20,0),
              child:SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                      children: [
                      Text(
                        " Detailed Reports screen",style: MyTextStyle.make("title"),
                      ),
                      SizedBox(height:20),
                      Text(
                        "Z report ID : ${detailedReportController.zreport_id}",style: MyTextStyle.make("title"),
                      ),
                      Text(
                        " Sold Products",style: MyTextStyle.make("body"),
                      ),
                      SizedBox(height:10),
                      FutureBuilder(future : detailedReportController.salesDao.getSaleList_by_zreport_id(detailedReportController.zreport_id),
                          builder: (context, snapshot)
                          {
                            detailedReportController.salesList = snapshot.data as List<Sale>;
                            return  DataTable(
                                columns: [
                                  DataColumn(label: Text("Id")),
                                  DataColumn(label: Text("Date")),
                                  DataColumn(label: Text("Product")),
                                  DataColumn(label: Text("Amount kg")),
                                  DataColumn(label: Text("farmer number")),
                                  DataColumn(label: Text("User Name")),

                                ],

                                rows: detailedReportController.salesList.map((e) => detailedReportController.makedatarow_of_sales(e)).toList());

                          }),
                      SizedBox(height: 20,),
                      Text(
                        " Purchased Products",style: MyTextStyle.make("body"),
                      ),
                      SizedBox(height:10),
                      FutureBuilder(future : detailedReportController.database.getPurchaseList_by_zreport_id(detailedReportController.zreport_id),
                          builder: (context, snapshot)
                          {
                            detailedReportController.purchaseList = snapshot.data as List<Purchase>;
                            return  DataTable(
                                columns: [
                                  DataColumn(label: Text("Id")),
                                  DataColumn(label: Text("Date")),
                                  DataColumn(label: Text("Product")),
                                  DataColumn(label: Text("Amount kg")),
                                  DataColumn(label: Text("farmer number")),
                                  DataColumn(label: Text("User Name")),

                                ],

                                rows: detailedReportController.purchaseList.map((e) => detailedReportController.makedatarow_of_purchases(e)).toList());

                          }),
                    ]),
              )),
          ),
        ),
      ),
    );
  }
}
