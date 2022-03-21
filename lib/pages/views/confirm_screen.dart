

import 'package:agric/pages/controller/confirm_controller.dart';
import 'package:agric/styles/button_decoration.dart';
import 'package:agric/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class ConfirmScreen extends GetView{
  final ConfirmController confirmController = Get.put(ConfirmController());
  @override
  Widget build(BuildContext context) {
    confirmController.get_previous_data();
    return Scaffold(
      appBar: AppBar(
        title: Text("Confirm Details below",style: MyTextStyle.make("body"),),
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                SizedBox(height:20),
                Text("Product : ${confirmController.current_data["product"]}",style: MyTextStyle.make("body"),),
                SizedBox(height:20),
                Text("Quantity in kg : ${confirmController.current_data["amount"]}",style: MyTextStyle.make("body")),
                SizedBox(height:20),
                Text("Farmer No : ${confirmController.current_data["farmer_number"]}",style: MyTextStyle.make("body")),
                SizedBox(height:20),
                Container(
                  width: double.infinity,
                  child: TextButton(onPressed:() async{
                   confirmController.on_press_confirm();
                  }, child: Text("Confirm",style: MyTextStyle.make("body-white"),),style: MyButtonDecoration.make(),),
                ),
                SizedBox(height:20),
              ],
            ),
          ),
        ),
      ),
    );
  }


}