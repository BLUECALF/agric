
import 'package:agric/database/database.dart';
import 'package:agric/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrintingController extends GetxController
{
  final AppDatabase database = Get.find<AppDatabase>();
  Map previous_data ={};

  // what i need to make the recipt
  late Sale current_sale ;
  late Purchase current_purchase;
  late String merchant;
  late String action;
  var transaction_object;
  late List<TotalSale> total_sale_list=[];

  late List<TotalPurchase> total_purchase_list=[];

  void get_data_from_trade_screen(BuildContext context)
  {
    print(" data from trade screen r ${Get.arguments}");
   previous_data =  ModalRoute.of(context)!.settings.arguments  as Map;
   transaction_object = previous_data["transaction_object"];
   merchant = previous_data["merchant"];
   action = previous_data["action"];

   if(action == "sell_product")
   {
     current_sale = previous_data["transaction_object"];
   }else
   {
     current_purchase = previous_data["transaction_object"];
   }

  }

  //get data from db
  get_data_from_db() async
  {
    if(action=="sell_product")
    {
      total_purchase_list = await database.getTotalPurchaseList_of_farmer_number(current_sale.farmer_number);
      total_sale_list =  await database.getTotalSaleList_of_farmer_number(current_sale.farmer_number);
    }else if(action=="buy_product")
    {
      total_purchase_list = await database.getTotalPurchaseList_of_farmer_number(current_purchase.farmer_number);
      total_sale_list =  await database.getTotalSaleList_of_farmer_number(current_purchase.farmer_number);
    }
     update();
  }

  // show transaction details
  String show_transaction_details(String action)
  {
    if(action=="sell_product")
    {
      String details = "Product : ${current_sale.product} \n"
          "Farmer number : ${current_sale.farmer_number} \n"
          "Amount in KG :${current_sale.amount_kg}";
      return details;
    }
    if(action=="buy_product")
    {

      String details = "Product : ${current_purchase.product} \n"
          "Farmer number : ${current_purchase.farmer_number} \n"
          "Amount in KG :${current_purchase.amount_kg}";
      return details;
    }
    return "";
  }
  Widget render_net_total()
  {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 20),

            Text("NET TOTAL",style: MyTextStyle.make("title"),),
            Text("Farmer Sold to US:",style: MyTextStyle.make("body"),),
            Column(
              children: total_purchase_list.map((e) => Text("${e.product} \t"
                  "${e.amount_kg} KGS"
                ,style: MyTextStyle.make("body"),)).toList(),
            ),

            SizedBox(height: 20),
            Text("Farmer Purchased From US:",style: MyTextStyle.make("body"),),
            Column(
              children: total_sale_list.map((e) => Text("${e.product} \t"
                  "${e.amount_kg} KGS"
                ,style: MyTextStyle.make("body"),)).toList(),
            ),
          ],
        ),
      ),
    );
  }


}