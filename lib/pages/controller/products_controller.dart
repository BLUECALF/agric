
import 'package:agric/database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController
{
  final database = Get.find<AppDatabase>();
  final _formKey = GlobalKey<FormBuilderState>();
  Map current_data={};
  String message="";

  List<String> actions = ["add product","remove product"];
  List<String> product_type = ["sellable product","purchasable product"];

  // validate form
  bool valdate_details(GlobalKey<FormBuilderState> _formKey)
  {
    message ="";

    var validate = _formKey.currentState?.validate();

    if(validate==true)
    { _formKey.currentState?.save();
    current_data = _formKey.currentState!.value;
    print("current data amap $current_data");
    print(current_data);
    message = "${current_data["action"]} of ${_formKey.currentState?.fields["product"]?.value} Recorded Successfully";
    _formKey.currentState?.reset();
    return true;
    }
    else message = "Couldn't Complete action"; return false;
  }

  /// ON PRESS OF THE SUBMIT BUTTON.
  void on_press_submit()async
  {

    bool valid = valdate_details(_formKey);
    if(valid)
    {await Perform_action(current_data);}

    // show results
    Get.defaultDialog(
      title: "Information",
      content:Text("${message}"),
      actions: [
        TextButton(onPressed: (){Get.back();}, child: Text(" OK")),
      ],
    );
  }

  // perform action
  Perform_action(Map current_data) async {
    String action = current_data["action"];
    String product = current_data["product"];
    String product_type = current_data["product_type"];

    if(action == "add product" && product_type == "sellable product")
    {
      print(" add sellable product :called");

      try{
        var row = await database.insertSellableProduct(Sellable_product(
            product_name: product

        ));
        print("Row In add sellable product : $row");

        if(row<0)
        {
          // product was not inserted
          message = "Error Occured in $action of $product_type";
        }
      }
      catch(e)
      {
        // code that will happen incase we get error lile sql error
        print("Catch code runned and error occured");
        message = "Error Occured in $action of $product_type \n "+
            "The error is ${e.toString()}";
      }


    }
    else  if(action == "add product" && product_type == "purchasable product")
    {

      print(" add purchasable product :called");
      try {
        var row = await database.insertBuyableProduct(Buyable_product(
            product_name: product
        ));

        print("Row In add purchasable product : $row");

        if(row<0)
        {
          // product was not inserted
          message = "Error Occured in $action of $product_type";
        }

      }catch(e)
      {
        // code that will happen incase we get error lile sql error
        print("Catch code runned and error occured");
        message = "Error Occured in $action of $product_type \n "+
            "The error is ${e.toString()}";
      }


    }

    else  if(action =="remove product" && product_type == "sellable product")
    {
      print(" remove sellable product :called");
      var row = await database.deleteSellable_product(Sellable_product(
          product_name: product
      ));
      print("Row In remove sellable product : $row");

      if(row<0)
      {
        // product was not removed.
        message = "Error Occured in $action of $product_type";
      }

    }

    else  if(action == "remove product" && product_type == "purchasable product")
    {
      print(" remove purchasable product :called");
      var row = await database.deleteBuyable_product(Buyable_product(
          product_name: product
      ));
      print("Row In remove Buyable product : $row");

      if(row<0)
      {
        // product was not removed.
        message = "Error Occured in $action of $product_type";
      }

    }

  }
  // form key getter
  GlobalKey<FormBuilderState> get_formkey()
  {
    return _formKey;
  }
}