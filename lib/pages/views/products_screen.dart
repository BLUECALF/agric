import 'package:agric/database/database.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart' as a;
import 'package:agric/styles/gradient_colors.dart';
import 'package:agric/pages/controller/products_controller.dart';
import 'package:agric/styles/button_decoration.dart';
import 'package:agric/styles/text_field_decoration.dart';
import 'package:agric/styles/text_style.dart';
import "package:flutter/material.dart";
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';


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

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Text("Purchasable Products"),
            Container(
              height: 200,
              width: Get.width,
              child: StreamBuilder(stream: productsController.database.getBuyable_productListStream(),
                  builder: (context,snapshot)
              {
                if(snapshot.data == null)
                {return Text("There are no Purchasable products");}
                print("snaphot  data is ");
                print(snapshot.data);
                if(snapshot.hasError)
                {return Text("Error in Purchasable products :,${snapshot.toString()}");}
                List<Buyable_product> buyable_product_list  = snapshot.data as List<Buyable_product>;
                return productsController.render_purchasable_products(buyable_product_list);
              }
              ),
            ),

            Text("Sellable Products"),
            Container(
              height: 200,
              width: Get.width,
              child: StreamBuilder(stream: productsController.database.getSellable_productListStream(),
                  builder: (context,snapshot)
                  {
                    if(snapshot.data == null)
                    {return Text("There are no Sellable products");}
                    print("snaphot  data is ");
                    print(snapshot.data);
                    if(snapshot.hasError)
                    {return Text("Error in sellable products :,${snapshot.toString()}");}
                    List<Sellable_product> sellable_product_list  = snapshot.data as List<Sellable_product>;
                    return productsController.render_sellable_products(sellable_product_list);
                  }
              ),
            ),


          ],

        ),
      ),
          floatingActionButton: a.GradientFloatingActionButton.extended(
            onPressed: () {
              Get.defaultDialog(
                content: Column(
                  children: [
                    FormBuilder(
                      key: productsController.get_formkey(),
                      autovalidateMode: AutovalidateMode.onUserInteraction,

                      child: Column(
                        children: [

                          FormBuilderDropdown(validator: (value){
                            if(value==null) return "Please Product Type";
                          }, decoration: MyTextFieldDecoration.make("Choose Product type"), name: "product_type",
                              items: productsController.product_type.map((choice) =>
                                  DropdownMenuItem(
                                    child: Text("$choice",style: MyTextStyle.make("body"),),value: choice,)).toList()
                          ),
                          SizedBox(height:20),

                          FormBuilderTextField(name: "product",
                            style: MyTextStyle.make("body"),
                            decoration: MyTextFieldDecoration.make("Name (Unique)"),
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.text,
                            cursorWidth: 5,
                            textCapitalization: TextCapitalization.characters,
                            validator: (value){
                              if(value == "" || value == null)
                              {return "Enter product name must be unique";}
                              else{return null;}
                            },
                          ),
                          SizedBox(height: 20,)

                        ],
                      ),
                    ),

                    Container(
                      width: Get.width,
                      child: TextButton(onPressed:() {
                        productsController.on_press_submit();
                      }, child: Text("Submit",style: MyTextStyle.make(""),),style: MyButtonDecoration.make(),),
                    ),
                  ],
                ),
                  title: "Add Product");
            },
            label: Text("Add Product"),
            icon: Icon(Icons.add),
            shape: StadiumBorder(),
            gradient: g3,
          ),
    );
  }


}
