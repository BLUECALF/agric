

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
    detailedReportController.get_objects();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        elevation: 0,
      ),
      backgroundColor: Colors.greenAccent,
      body: SafeArea(
        child:Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20,50,20,0),

              child:ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    Text(
                      " Detailed Reports screen",style: MyTextStyle.make("title"),
                    ),
                    SizedBox(height:20),
                    Text(
                      "Z report ID : ${detailedReportController.zreport_id}",style: MyTextStyle.make("title"),
                    ),
                    Text(
                      " Purchased Products",style: MyTextStyle.make("body"),
                    ),
                    SizedBox(height:10),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container( child: Text("Product"),decoration: BoxDecoration(
                            color: Colors.greenAccent,

                          ),),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(child: Text("Farmer No"),decoration: BoxDecoration(
                            color: Colors.greenAccent,
                          ),),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(child: Text("amount In kg",),decoration: BoxDecoration(
                            color: Colors.greenAccent,
                          ),),
                        ),

                      ],
                    ),
                    FutureBuilder(
                      future: detailedReportController.database.getPurchaseList_by_zreport_id(detailedReportController.zreport_id),
                      builder:(context,snapshot) {
                        List<Purchase> purchaseList = snapshot.data as List<Purchase>;
                        return Column(
                        children: purchaseList.map((purchase) => detailedReportController.makerow_of_purchase(purchase)).toList(),
                      );},
                    ),
                    SizedBox(height: 20,),
                    Text(
                      " Sold Products",style: MyTextStyle.make("body"),
                    ),
                    SizedBox(height:10),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(child: Text("Product"),decoration: BoxDecoration(
                            color: Colors.greenAccent,
                          ),),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(child: Text("Farmer No"),decoration: BoxDecoration(
                            color: Colors.greenAccent,
                          ),),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(child: Text("Amount in kg"),decoration: BoxDecoration(
                            color: Colors.greenAccent,
                          ),),
                        ),
                      ],
                    ),
                    FutureBuilder(
                      future: detailedReportController.salesDao.getSaleList_by_zreport_id(detailedReportController.zreport_id),
                      builder:(context,snapshot) {
                        List<Sale> saleList = snapshot.data as List<Sale>;
                        return Column(
                          children: saleList.map((sale) => detailedReportController.makerow_of_sales(sale)).toList(),
                        );},
                    ),
                  ])),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {print("refresh called");
      detailedReportController.update();
      },child: Icon(Icons.refresh,color: Colors.redAccent[300],),),
    );
  }
}
