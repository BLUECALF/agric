import "package:flutter/material.dart";
import 'package:get/get.dart';

import '../../database/database.dart';
import '../../styles/text_style.dart';

class FarmersScreen extends GetView {
  final database = Get.find<AppDatabase>();
  late List<Farmer>  farmers_list;
  @override
  Widget build(BuildContext context) {
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
                          "List Of Farmers",style: MyTextStyle.make("title"),
                        ),
                        SizedBox(height:10),
                        FutureBuilder(future : database.getFarmerList(),
                            builder: (context, snapshot)
                            {

                              if(snapshot.data == null)
                                {return Text(
                                  "There are no farmers ",style: MyTextStyle.make("body"),
                                );}
                              farmers_list = snapshot.data as List<Farmer>;
                              if(farmers_list.length == 0 )
                                {
                                  return Text(
                                    "There are no farmers ",style: MyTextStyle.make("body"),
                                  );
                                }

                              return  DataTable(
                                  columns: [
                                    DataColumn(label: Text("Full Names")),
                                    DataColumn(label: Text("Unique ID")),
                                    DataColumn(label: Text("Farmer No")),
                                    DataColumn(label: Text("Milk Balance"))
                                  ],

                                  rows: farmers_list.map((e) => DataRow(cells: [
                                    DataCell(Text(e.fullname)),
                                    DataCell(Text(e.id)),
                                    DataCell(Text(e.farmer_number)),
                                    DataCell(FutureBuilder(
                                        future: database.getTotalPurchase_using_farmer_no_and_product(farmer_number: e.farmer_number, product: "MILK"),
                                        builder: (context,snapshot)
                                        {
                                          if(snapshot.data == null)
                                          {return Text("0",style: MyTextStyle.make("body"),
                                          );
                                          }
                                          List<TotalPurchase> total_purchaselist = snapshot.data as List<TotalPurchase>;
                                          if(total_purchaselist.length == 0)
                                            {
                                              return Text("0",style: MyTextStyle.make("body"));
                                            }
                                          else
                                            {
                                              return Text(total_purchaselist[0].amount_kg.toString(),style: MyTextStyle.make("body"),);
                                            }

                                        }

                                    )

                                    ),
                                  ])).toList());

                            }),
                      ]),
                )),
          ),
        ),
      ),
    );
  }
}
