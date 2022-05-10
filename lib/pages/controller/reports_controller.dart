import 'package:gradient_ui_widgets/gradient_ui_widgets.dart' as a;
import 'package:agric/AppController/app_controller.dart';
import 'package:agric/database/database.dart';
import 'package:agric/pages/views/detailed_report_screen.dart';
import 'package:agric/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReportsController extends GetxController
{
  late AppController appController = Get.find<AppController>();
  late AppDatabase database  = Get.find<AppDatabase>();
  final SalesDao salesDao = Get.find<SalesDao>();
  List<Sale> salesList =[];
  List<Purchase> purchaseList=[];
  List<Zreport> zreportList=[];

  // get data from db
  get_objects() async
  {
    salesList = await salesDao.getSaleList();
    purchaseList = await database.getPurchaseList();
    zreportList = await database.getZreportList(appController.username);
    // after we get values we recall build by update
    update();
    print("Z REPORT DATA IS \n\n ${zreportList}");
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


  /// Make Roe of Z report
  Widget makerow_of_zreport(Zreport z) {
    var full_date =  z.date;
    final _dayFormater = DateFormat('d');
    final _monthFormater = DateFormat('M');
    final _yearFormater = DateFormat('y');

    var date = "${_dayFormater.format(full_date)}-${_monthFormater.format(full_date)}-${_yearFormater.format(full_date)}";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [

            Expanded(
              flex: 2,
              child: Container(child: Text("${date}"), decoration: BoxDecoration(
                color: Colors.grey,
              ),),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Text("${z.transactions_sold}"), decoration: BoxDecoration(
                color: Colors.grey[400],
              ),),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Text("${z.units_sold}"), decoration: BoxDecoration(
                color: Colors.grey[300],
              ),),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Text("${z.transactions_bought}"), decoration: BoxDecoration(
                color: Colors.grey[300],
              ),),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Text("${z.units_bought}"), decoration: BoxDecoration(
                color: Colors.grey[300],
              ),),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Text("${z.username}",style: MyTextStyle.make("small"),), decoration: BoxDecoration(
                color: Colors.grey[300],
              ),),
            ),

          ],

        ),
        Container(
          height: 20,
          child: ElevatedButton(onPressed: ()
          {
            print("the Z report has id of ${z.zreport_id}");
            Get.to(DetailedReportsScreen(),arguments: {"zreport_id":z.zreport_id});

            },
              child: Text("View Details",style: MyTextStyle.make("tiny"),),
              ),
        ),
      ],
    );
  }


  DataRow makedatarow_of_zreport(Zreport z) {
    var full_date =  z.date;
    final _dayFormater = DateFormat('d');
    final _monthFormater = DateFormat('M');
    final _yearFormater = DateFormat('y');

    var date = "${_dayFormater.format(full_date)}-${_monthFormater.format(full_date)}-${_yearFormater.format(full_date)}";
    return DataRow(
        cells: [
   DataCell(Text("${date}")),
          DataCell(Text("${z.transactions_sold}")),
          DataCell(Text("${z.units_sold}")),
          DataCell(Text("${z.transactions_bought}")),
          DataCell(Text("${z.units_bought}")),
          DataCell(Text("${z.username}")),
          DataCell(Row(
            children: [
              a.GradientElevatedButton(onPressed: ()
              {
                print("the Z report has id of ${z.zreport_id}");
                Get.to(DetailedReportsScreen(),arguments: {"zreport_id":z.zreport_id});

              },
                gradient:appController.g3,
                child: Text("View Details",style: MyTextStyle.make("tiny"),),
              ),
              IconButton(onPressed: ()
              async{
                // check if there are printers connected
                if(!appController.bluePrintPos.isConnected)
                {
                  // user has no printing device ... canot transact
                  Get.defaultDialog(title: "Error",content: Text("Please Add a bluetooth printer to continue"),
                      textConfirm: "ok",
                      onConfirm: (){Get.back();});
                  return;
                }
                // MAKE RECEIPTSECTION TEXT FOR THE X REPORT
                await appController.bluePrintPos.printReceiptText(await appController.prepare_zreport_receipt(z));

              print("the Z report has id of ${z.zreport_id}");
              },
              icon: Icon(Icons.receipt),
              ),
            ],
          ),),

    ]);
  }

}