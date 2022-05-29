

import 'package:agric/database/database.dart';
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
    bool accepted = false;
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
                FutureBuilder(
                  future: confirmController.database.getFarmer(confirmController.current_data["farmer_number"]),
                  builder: (context,snapshot)
                  {
                    if(snapshot.data == null || (snapshot.data as List<Farmer> == []))
                    {
                      return Text("The Farmer is not in the Database",style: MyTextStyle.make("body"));
                    }
                    List<Farmer> farmer_list = (snapshot.data as List<Farmer>);

                    for(int i = 0;i <farmer_list.length ;i++)
                      {
                       Farmer farmer = farmer_list[i];
                       accepted = true;
                        return  Text("Name : ${farmer.fullname}" ,style: MyTextStyle.make("body"));
                      }
                    return Text("Farmer is not in the Database",style: MyTextStyle.make("body"));
                  },
                ),
                Container(
                  width: double.infinity,
                  child: TextButton(onPressed:() async{
                    if(!accepted){
                      Get.defaultDialog(title:"Notice"
                          , textConfirm: "ok",content: Text("Cannot transact with unknown farmer"),
                          onConfirm: (){Get.back();Get.back();}
                      );
                      return;
                    }
                    await confirmController.database.transaction(() => confirmController.on_press_confirm());

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