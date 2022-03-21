import 'package:agric/database/database.dart';
import 'package:agric/pages/controller/printing_controller.dart';
import 'package:agric/styles/text_style.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class PrintingScreen extends StatelessWidget {

  final PrintingController printingController = Get.put(PrintingController());

  @override
  Widget build(BuildContext context) {
    printingController.get_data_from_trade_screen(context);
    printingController.get_data_from_db();

    return Scaffold(
      appBar: AppBar(
        title: Text("Printing Screen"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: GetBuilder<PrintingController>(builder: (_)
    {return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("AGRIC TRANSACTION RECIEPT",style: MyTextStyle.make("body"),),

          SizedBox(height: 20),
          Text("current transaction",style: MyTextStyle.make("title"),),
          SizedBox(height: 20),
          Text("Served By : ${printingController.merchant}",style: MyTextStyle.make("title"),),
          SizedBox(height: 20),
          Text(printingController.show_transaction_details(printingController.action),style: MyTextStyle.make("body"),),
          printingController.render_net_total(),
        ],
      );}),
      floatingActionButton: FloatingActionButton(
        onPressed: (){printingController.on_press_print();},
        child: Icon(Icons.print),
      ),

    );
  }





}
