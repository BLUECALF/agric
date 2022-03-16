

import 'package:agric/pages/controller/reports_controller.dart';
import 'package:agric/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';





class ReportsScreen extends StatelessWidget {

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
        child:Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20,50,20,0),

              child: GetBuilder<ReportsController>(builder: (_){ return ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Text(
                    " Reports screen",style: MyTextStyle.make("title"),
                  ),
                  SizedBox(height:10),
                  Text(
                    " Z- reports ",style: MyTextStyle.make("body"),
                  ),
                  SizedBox(height:10),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container( child: Text("Date",style: MyTextStyle.make("tiny"),),decoration: BoxDecoration(
                          color: Colors.greenAccent,

                        ),),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(child: Text("Transactions sold",style: MyTextStyle.make("tiny"),),decoration: BoxDecoration(
                          color: Colors.greenAccent,
                        ),),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(child: Text("Units Sold",style: MyTextStyle.make("tiny"),),decoration: BoxDecoration(
                          color: Colors.greenAccent,
                        ),),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(child: Text("transactions bought",style: MyTextStyle.make("tiny"),),decoration: BoxDecoration(
                          color: Colors.greenAccent,
                        ),),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(child: Text("Units Bought",style: MyTextStyle.make("tiny"),),decoration: BoxDecoration(
                          color: Colors.greenAccent,
                        ),),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(child: Text("User Name ",style: MyTextStyle.make("tiny"),),decoration: BoxDecoration(
                          color: Colors.greenAccent,
                        ),),
                      ),

                    ],
                  ),
                  Column(
                    children: reportsController.zreportList.map((z) => reportsController.makerow_of_zreport(z)).toList(),
                  ),
                  SizedBox(height:20),

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
                  Column(
                    children: reportsController.purchaseList.map((purchase) => reportsController.makerow_of_purchase(purchase)).toList(),
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
                  Column(
                    children: reportsController.salesList.map((sales) => reportsController.makerow_of_sales(sales)).toList(),
                  ),
            ]);}),),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {print("refresh called");
       reportsController.update();
      },child: Icon(Icons.refresh,color: Colors.redAccent[300],),),
    );
  }
}
