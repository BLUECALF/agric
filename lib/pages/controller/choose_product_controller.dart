
import 'package:agric/database/database.dart';
import 'package:agric/pages/views/trade_screen.dart';
import 'package:agric/styles/button_decoration.dart';
import 'package:agric/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseProductController extends GetxController
{
  Map previous_data = {};
  List<Sellable_product> sellable_products_list = [];
  List<Buyable_product> purchasable_products_list = [];

  List<Widget> render_buttons()
  {
    // get data from arguments
    previous_data = Get.arguments;
    if(previous_data.isEmpty)
      {
        Get.defaultDialog(title: "Error happened - no data was recived");
        Get.off(TradeScreen());
        return [Text("Error")];
      }
    else if(previous_data["action"]=="sell_product")
      {
        // we render sellable products
        sellable_products_list = previous_data["items"];

      return  sellable_products_list.map((e) => TextButton(
           onPressed: (){
             // go back
            Get.back(result: e.product_name);
           },
          style: MyButtonDecoration.make(),
           child:Text(e.product_name,style: MyTextStyle.make("body-white"),))).toList();

      }
    else if(previous_data["action"]=="buy_product")
    {
      // we render sellable products
      purchasable_products_list = previous_data["items"];

      return  purchasable_products_list.map((e) => TextButton(
          onPressed: (){
            // go back
            Get.back(result: e.product_name);
          },
          style: MyButtonDecoration.make(),
          child:Text(e.product_name,style: MyTextStyle.make("body-white"),))).toList();
    }
    return [Text("Error Occurred")];
  }


}