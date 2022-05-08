
import 'package:agric/AppController/app_controller.dart';
import 'package:agric/database/database.dart';
import 'package:agric/pages/views/choose_product_screen.dart';
import 'package:agric/pages/views/confirm_screen.dart';
import 'package:agric/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class TradeController extends GetxController
{
  Map previous_data = {};
  Map current_data={};

  String title = "";
  String merchant = "";
  String action ="";
  String message = "";

  late AppDatabase database =  Get.find<AppDatabase>();
  final AppController appController = Get.find<AppController>();
  List<Xreport> xreportList =[];

  List<Buyable_product> buyable_products = [];
  List<Sellable_product> sellable_products =[];

  void get_previous_data()
  {
    merchant = appController.username;


  }
  get_data_from_db() async
  {
    buyable_products = await database.getBuyable_productList();
    sellable_products = await database.getSellable_productList();
   ///  we will use update instead of set state.
    buyable_products = buyable_products;
    sellable_products = sellable_products;
    print("Buyable products are $buyable_products");
    update();
    title = (action == "buy_product")? "BUY PRODUCT":"SELL PRODUCT";
  }
  /// GET A LIST OF DROPDOWN iTEMS

  List<DropdownMenuItem<String>> get_dropdown_items()
  {
    if(action=="buy_product")
    {
      //check if the list is empty
      if(buyable_products.isEmpty)
      {
        return [DropdownMenuItem(
            child: Card(child: Container(height: 20 ,child: Text("there is no purchasable products")))),];
      }
      List<DropdownMenuItem<String>>  buyable_list = buyable_products.map((obj) {
        return DropdownMenuItem(
          child: Text("${obj.product_name}",style: MyTextStyle.make("body"),),value: obj.product_name,);
      }).toList();
      return buyable_list;
    }
    else
    {

      //check if the list is empty
      if(sellable_products.isEmpty)
      {
        return [DropdownMenuItem(
            child: Card(child: Text("there is no Sellable products"))),];
      }

      List<DropdownMenuItem<String>>  sellable_list = sellable_products.map((obj) {
        return DropdownMenuItem(
          child: Text("${obj.product_name}",style: MyTextStyle.make("body"),),value: obj.product_name,);
      }).toList();
      return sellable_list;
    }
  }

 void on_press_submit(GlobalKey<FormBuilderState> _formKey,TextEditingController textEditingController)
  async{


    bool accept;
    message ="";
 /// validate form
    var validate = _formKey.currentState?.validate();

    if(validate==true)
    { _formKey.currentState?.save();
    current_data = _formKey.currentState!.value;
    print("current data amap $current_data");
    print(current_data);
    message = "$title of ${textEditingController.text} Recorded Successfully";
    _formKey.currentState?.reset();
    accept = true;
    }
    else {message = "Couldn't Complete action $action"; accept = false;}

    // all is well
    if(accept){
      appController.transaction_data = {
        "action":action,
    "data":current_data
    };
      ///DATA IS OK, NOW FOWARD TO CONFIRM PAGE
      Get.to(() =>ConfirmScreen(),);
      print("The data passed Is ::::\n$current_data");
      print("the action is ::$action");
    }
    if(!accept) {
    Get.defaultDialog(
      title: title,
      content:Text("${message}"),
    );}


  }

  /*/// INSERT THE DATA TO DATABASE
  insert_to_database(String action) async
  {
    if(current_data.isEmpty)
    {
      // this means user hasent filled the fields
      return;
    }

    xreportList = await database.getXreportList();

    Xreport xreport_object = xreportList[0];

    List<TotalSale> totalSaleList;
    List<TotalPurchase> totalPurchaseList;

    TotalSale new_total_sale_object;
    TotalSale total_sale_object;

    TotalPurchase new_total_purchase_object;
    TotalPurchase total_purchase_object;

    // action can be buy_product or sell_product

    if(action=="buy_product")
    {
      Purchase p = Purchase(farmer_number: current_data["farmer_number"],
        product: current_data["product"],
        amount_kg: double.parse(current_data["amount"]),
      );

      int rows  =  await database.insertPurchase(p);
      if(rows <= 0)
      {message = "Failed to Record $action transaction";}
      print("Rows affected in Buy are $rows");

      if(rows > 0)
      {
        // transaction did happen.

        Xreport xreport_updated = Xreport(
          id:xreport_object.id,
          transactions_bought: (xreport_object.transactions_bought + 1),
          transactions_sold: (xreport_object.transactions_sold),
          units_bought: (xreport_object.units_bought + p.amount_kg),
          units_sold: (xreport_object.units_sold),
        );
        bool result = await database.updateXreport(xreport_updated);

        String m =result?"Xreport upddated":"Xreport Not Updated";
        print(m);

        // we then update the farmers totals in total Purchase

        totalPurchaseList = await database.getTotalPurchase_using_farmer_no_and_product(
            farmer_number: current_data["farmer_number"],
            product: current_data["product"]);
        // check if there is no record like that

        if(totalPurchaseList.isEmpty)
        {
          // initialize the total sale object
          // means there is no record of tis type of Totalpurchase in db
          //so we add a new one.
          new_total_purchase_object = TotalPurchase(
              product: current_data["product"],
              amount_kg: double.parse(current_data["amount"]),
              farmer_number: current_data["farmer_number"]);

          int  rows_affected  = await database.insertTotalPurchase(new_total_purchase_object);

          if(rows_affected>0)
          {
            print("## the insertion to total purchase table was recorded successfully");
            // proceed to printing screen
            Get.to(PrintingScreen(),arguments: {
              "merchant":merchant,
              "action":"buy_product",
              "transaction_object":p,
            });
          }
          else{
            print("\$\$ insertion to total Purchase table FAILED");
          }
        }else {

          total_purchase_object = totalPurchaseList[0];

          new_total_purchase_object = TotalPurchase(
              product: current_data["product"],
              amount_kg: total_purchase_object.amount_kg + double.parse(current_data["amount"]),
              farmer_number: current_data["farmer_number"]);

          // update the database
          bool rows_affected  = await database.updateTotalPurchase(new_total_purchase_object);

          if(rows_affected)
          {
            print("## the insertion to total purchase table was recorded successfully");
            //proceed to printing screen
            Get.to(PrintingScreen(),arguments: {
              "merchant":merchant,
              "action":"buy_product",
              "transaction_object":p,
            });
          }
          else{
            print("\$\$ insertion to total Purchase table FAILED");
          }

        }
      }

    }
    else if(action=="sell_product")
    {
      Sale s = Sale(farmer_number: current_data["farmer_number"],
        product: current_data["product"],
        amount_kg: double.parse(current_data["amount"]),
      );
      final salesDao = Get.find<SalesDao>();

      int rows  =  await salesDao.insertSale(s);
      if(rows <= 0)
      {message = "Failed to Record $action transaction";}
      print("Rows affected in sell are $rows");

      if(rows>0)
      {
        // transaction did happen.

        Xreport xreport_updated = Xreport(
          id:(xreport_object.id),
          transactions_bought: (xreport_object.transactions_bought),
          transactions_sold: (xreport_object.transactions_sold + 1),
          units_bought: (xreport_object.units_bought),
          units_sold: (xreport_object.units_sold + s.amount_kg),
        );
        bool result = await database.updateXreport(xreport_updated);

        String m =result?"Xreport upddated":"Xreport Not Updated";
        print(m);

        // we then update the farmers totals in total sales

        totalSaleList = await database.getTotalSale_using_farmer_no_and_product(
            farmer_number: current_data["farmer_number"],
            product: current_data["product"]);
        // check if there is no record like that

        if(totalSaleList.isEmpty)
        {
          // means there is no record of tis type of TotalSale in db
          //so we add a new one.
          new_total_sale_object = TotalSale(
              product: current_data["product"],
              amount_kg: double.parse(current_data["amount"]),
              farmer_number: current_data["farmer_number"]);
          // insert them to database
          int rows_affected  = await database.insertTotalSale(new_total_sale_object);

          if(rows_affected>0)
          {
            print("## the insertion to total sale table was recorded successfully");
            Get.to(PrintingScreen(),arguments: {
              "merchant":merchant,
              "action":"sell_product",
              "transaction_object":s,
            });
          }
          else{
            print("\$\$ insertion to total sales table FAILED");
          }
        }else {

          // get object ot total sales
          total_sale_object = totalSaleList[0];

          new_total_sale_object = TotalSale(
              product: current_data["product"],
              amount_kg: total_sale_object.amount_kg + double.parse(current_data["amount"]),
              farmer_number: current_data["farmer_number"]);
        }
        // update Database
        bool rows_affected  = await database.updateTotalSale(new_total_sale_object);

        if(rows_affected)
        {
          print("## the insertion to total sale table was recorded successfully");
          Get.to(PrintingScreen(),arguments: {
            "merchant":merchant,
            "action":"sell_product",
            "transaction_object":s,
          });
        }
        else{
          print("\$\$ insertion to total sales table FAILED");
        }
      }
    }
  }*/
  Widget render_transactions(GlobalKey<FormBuilderState> _formKey,TextEditingController textEditingController)
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
          Text("Sale",style: MyTextStyle.make("body"),),
         Radio(value: "sell_product", groupValue: action,
             onChanged: (value){action=value.toString();
           _formKey.currentState?.reset();
             textEditingController.text = "";
           update();

         }),

          Text("Purchase",style: MyTextStyle.make("body"),),
          Radio(value: "buy_product", groupValue: action,
              onChanged: (value){action=value.toString();
              _formKey.currentState?.reset();
              textEditingController.text = "";

            update();}),

      ],
    );
  }

  void on_press_choose_product(TextEditingController textEditingController) async {
    // take a list of products
    Map data = {};
    if(action == "sell_product")
      {
        data = {
          "items":sellable_products,
          "action":action
        };
      }
    else if(action == "buy_product")
    {
     data = {
       "items":buyable_products,
    "action":action
     };
    }
    else
      {
        Get.defaultDialog(title: "Error",content: Text("Choose a Transaction to continue"));
        return;
      }
    // foward to a choose page
     String choice =  await Get.to(ChooseProduct(),arguments: data);
    // fill the space with the choice
    textEditingController.text = choice;
    update();


  }
}