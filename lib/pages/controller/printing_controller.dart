
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
  late String action;
  var transaction_object;
  late List<TotalSale> total_sale_list=[];
  late Map<String,dynamic> current_transaction;

  late List<TotalPurchase> total_purchase_list=[];

  void get_data_from_trade_screen(BuildContext context)
  {
    print(" data from Confirm screen r ${Get.arguments}");
   previous_data =  ModalRoute.of(context)!.settings.arguments  as Map;
   transaction_object = previous_data["transaction_object"];
   merchant = previous_data["merchant"];
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
        "product" : current_sale.product,
        "farmer_number":current_sale.farmer_number,
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
        "product" : current_purchase.product,
        "farmer_number":current_purchase.farmer_number,
        "username":current_purchase.username,
        "amount_kg":current_purchase.amount_kg
      };
      return details;
    }
    return "";
  }
  Widget render_net_total()
  {
    on_press_print();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 20),

            Text("NET TOTAL",style: MyTextStyle.make("title"),),
            Text("Farmer Sold to US:",style: MyTextStyle.make("body"),),
            FutureBuilder(
              future: database.getTotalPurchaseList_of_farmer_number(farmer_number),
              builder: (context, snapshot)
              {
                if(snapshot.data == null)
                {
                  return Text("There is no Purchases");
                }
                total_purchase_list = snapshot.data as List<TotalPurchase>;
                return  Column(
                  children: total_purchase_list.map((e) => Text("${e.product} \t"
                      "${e.amount_kg} KGS"
                    ,style: MyTextStyle.make("body"),)).toList(),
                );

              },
            ),
            SizedBox(height: 20),
            Text("Farmer Purchased From US:",style: MyTextStyle.make("body"),),
            FutureBuilder(
              future: database.getTotalSaleList_of_farmer_number(farmer_number),
              builder: (context, snapshot)
              {
                if(snapshot.data == null)
                  {
                    return Text("There is no Sales");
                  }
                total_sale_list = snapshot.data as List<TotalSale>;
                return Column(
                  children: total_sale_list.map((e) => Text("${e.product} \t"
                      "${e.amount_kg} KGS"
                    ,style: MyTextStyle.make("body"),)).toList(),
                );
              },
            ),

          ],
        ),
      ),
    );
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

    await appController.prepare_text(data);
    await appController.bluePrintPos.printReceiptText(
        appController.receiptText,
      paperSize: PaperSize.mm72,
        useCut: false,
      feedCount: -10
    );
    await appController.bluePrintPos.printQR(data["current_transaction"]["id"].toString());
    ReceiptSectionText endl = ReceiptSectionText();
    endl.addText("end of qr code ",size: ReceiptTextSizeType.extraLarge);
    endl.addSpacer();
    appController.bluePrintPos.printReceiptText(endl);

    await Get.defaultDialog(title: "Printing",content: Column(
      children: [
        SpinKitChasingDots(
          size: 50.0,
          color: Colors.black,
        ),
        ElevatedButton(onPressed: (){Get.back();}, child: Text("OK")),
      ],
    ),);
    Get.off(TradeScreen());
  }
}
