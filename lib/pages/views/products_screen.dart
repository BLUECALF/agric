import 'package:agric/database/database.dart';
import 'package:agric/styles/button_decoration.dart';
import 'package:agric/styles/text_field_decoration.dart';
import 'package:agric/styles/text_style.dart';
import "package:flutter/material.dart";
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {

  late AppDatabase database;
  Map current_data={};
  String message="";


  final _formKey = GlobalKey<FormBuilderState>();

  List<String> actions = ["add product","remove product"];
  List<String> product_type = ["sellable product","purchasable product"];


  @override
  Widget build(BuildContext context) {

    database = Provider.of<AppDatabase>(context);

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
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,

            child: Column(
              children: [
                FormBuilderDropdown(validator: (value){
                  if(value==null) return "Please Choose an Action";
                }, decoration: MyTextFieldDecoration.make("Choose An action"), name: "action",
                    items: actions.map((choice) =>
                        DropdownMenuItem(
                          child: Card(
                            child:Text("$choice",style: MyTextStyle.make("body"),),),value: choice,)).toList()
                ),

                SizedBox(height:20),

                FormBuilderDropdown(validator: (value){
                  if(value==null) return "Please Product Type";
                }, decoration: MyTextFieldDecoration.make("Choose Product type"), name: "product_type",
                    items: product_type.map((choice) =>
                        DropdownMenuItem(
                          child: Card(
                            child:Text("$choice",style: MyTextStyle.make("body"),),),value: choice,)).toList()
                ),
                SizedBox(height:20),

                FormBuilderTextField(name: "product",
                  style: MyTextStyle.make("body"),
                  decoration: MyTextFieldDecoration.make("Product Name (Must be Unique)"),
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

          TextButton(onPressed:() async{
            message ="";
            setState((){
              var validate = _formKey.currentState?.validate();

              if(validate==true)
              { _formKey.currentState?.save();
              current_data = _formKey.currentState!.value;
              print("current data amap $current_data");
              print(current_data);
              message = "${current_data["action"]} of ${_formKey.currentState?.fields["product"]?.value} Recorded Successfully";
              _formKey.currentState?.reset();

              }
              else message = "Couldn't Complete action";

            });

            await Perform_action(current_data);

            var alertDialog = AlertDialog(
              title: Text(" Information"),
              content: Text("$message"),
              actions: [
                TextButton(onPressed: (){Navigator.pop(context);}, child: Text(" Yes")),
                TextButton(onPressed: (){}, child: Text(" No "))
              ],

            );
            showDialog(
              context: context,
              builder: (BuildContext context) => alertDialog,
              barrierDismissible: false,
            );


          }, child: Text("Submit",style: MyTextStyle.make(""),),style: MyButtonDecoration.make(),),

        ],

      ),

    );
  }

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
}
