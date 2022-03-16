import 'package:agric/database/database.dart';
import 'package:agric/pages/controller/products_controller.dart';
import 'package:agric/styles/button_decoration.dart';
import 'package:agric/styles/text_field_decoration.dart';
import 'package:agric/styles/text_style.dart';
import "package:flutter/material.dart";
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {

  final ProductsController productsController = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {

        return Scaffold(
      appBar: AppBar(
        title: Text("Products Screen "),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),

      body: Column(
        children: [
          Text("Add Or Remove Products"),
          FormBuilder(
            key: productsController.get_formkey(),
            autovalidateMode: AutovalidateMode.onUserInteraction,

            child: Column(
              children: [
                FormBuilderDropdown(validator: (value){
                  if(value==null) return "Please Choose an Action";
                }, decoration: MyTextFieldDecoration.make("Choose An action"), name: "action",
                    items: productsController.actions.map((choice) =>
                        DropdownMenuItem(
                          child: Card(
                            child:Text("$choice",style: MyTextStyle.make("body"),),),value: choice,)).toList()
                ),

                SizedBox(height:20),

                FormBuilderDropdown(validator: (value){
                  if(value==null) return "Please Product Type";
                }, decoration: MyTextFieldDecoration.make("Choose Product type"), name: "product_type",
                    items: productsController.product_type.map((choice) =>
                        DropdownMenuItem(
                          child: Card(
                            child:Text("$choice",style: MyTextStyle.make("body"),),),value: choice,)).toList()
                ),
                SizedBox(height:20),

                FormBuilderTextField(name: "product",
                  style: MyTextStyle.make("body"),
                  decoration: MyTextFieldDecoration.make("Product Name (Unique)"),
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.text,
                  cursorWidth: 5,
                  validator: (value){
                    if(value == "" || value == null)
                    {return "Enter Product Name";}
                    else{return null;}
                  },
                ),

              ],
            ),
          ),

          TextButton(onPressed:() {

            productsController.on_press_submit();
          }, child: Text("Submit",style: MyTextStyle.make(""),),style: MyButtonDecoration.make(),),

        ],

      ),

    );
  }


}
