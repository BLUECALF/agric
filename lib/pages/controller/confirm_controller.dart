
import 'package:agric/AppController/app_controller.dart';
import 'package:agric/database/database.dart';
import 'package:agric/pages/views/printing_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmController extends GetxController
{
  Map all_data={};
  Map current_data = {};

  String title = "";
  String merchant = "";
  String action ="";
  String message = "";

  late AppDatabase database =  Get.find<AppDatabase>();
  final salesDao = Get.find<SalesDao>();
  final AppController appController = Get.find<AppController>();
  List<Xreport> xreportList =[];

  List<Buyable_product> buyable_products = [];
  List<Sellable_product> sellable_products =[];

  void get_previous_data()
  {
    merchant = appController.username;
    all_data = appController.transaction_data;
    current_data = all_data["data"];
    action = all_data["action"];
    appController.transaction_data = {};

  }


  Future<void> on_press_confirm()
  async{

    message ="";
    title = (action == "buy_product")? "BUY PRODUCT":"SELL PRODUCT";
    message = "$title of ${current_data["product"]} Recorded Successfully";
    await insert_to_database(action);
    var tran_status = await database.transaction(() async {
       return "Completed";
    });
    print("TRANSACTION STATUS IS $tran_status");

    // show results
    Get.defaultDialog(
      title: title,
      content:Text("${message}"),
    );

  }

  /// INSERT THE DATA TO DATABASE
  insert_to_database(String action) async
  {
    if(current_data.isEmpty)
    {
      // this means user hasent filled the fields
      return;
    }

    xreportList = await database.getXreportList(appController.username);

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
      Purchase p = Purchase(
        id: await generate_purchase_id(),
        farmer_number: current_data["farmer_number"],
        product: current_data["product"],
        amount_kg: double.parse(current_data["amount"]),
        date: DateTime.now(),
        username: appController.username,
        zreport_id: -1,
      );

      int rows  =  await database.insertPurchase(p);
      if(rows <= 0)
      {message = "Failed to Record $action transaction";}
      print("Rows affected in Buy are $rows");

      if(rows > 0)
      {
        // transaction did happen.

        Xreport xreport_updated = Xreport(
        username: appController.username,
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
            print("## the insertion of NEW total purchase was recorded successfully");
            // proceed to printing screen
            Get.off(PrintingScreen(),arguments: {
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
            print("## the UPDATE  to total purchase table was recorded successfully");
            //proceed to printing screen
            Get.off(PrintingScreen(),arguments: {
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
      final s = Sale(
        id : await generate_sale_id() ,
        farmer_number: current_data["farmer_number"],
        product: current_data["product"],
        amount_kg: double.parse(current_data["amount"]),
        date: DateTime.now(),
        username: appController.username,
        zreport_id: -1,
      );
   

      int rows  =  await salesDao.insertSale(s);
      if(rows <= 0)
      {message = "Failed to Record $action transaction";}
      print("Rows affected in sell are $rows");

      if(rows>0)
      {
        // transaction did happen.

        Xreport xreport_updated = Xreport(
          username: appController.username,
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
          // means there is no record of this type of TotalSale in db
          //so we add a new one.
          new_total_sale_object = TotalSale(
              product: current_data["product"],
              amount_kg: double.parse(current_data["amount"]),
              farmer_number: current_data["farmer_number"]);
          // insert them to database
          int rows_affected  = await database.insertTotalSale(new_total_sale_object);

          if(rows_affected>0)
          {
            print("## the insertion  OF NEW total sale was recorded successfully");
            Get.off(PrintingScreen(),arguments: {
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
          print("## the UPDATE to total sale table was recorded successfully");
          Get.off(PrintingScreen(),arguments: {
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
  }
  Future<int> generate_sale_id()
  async{
    List<Sale> sale_list = await salesDao.getSaleList();
    if(sale_list.isEmpty)
    {return 1;}
    else
    {
      return (sale_list[sale_list.length -1]).id + 1 ;
    }
  }
  Future<int> generate_purchase_id()
  async{
    List<Purchase> purchase_list = await database.getPurchaseList();
    if(purchase_list.isEmpty)
    {return 1;}
    else
    {
      return (purchase_list[purchase_list.length -1]).id+ 1 ;
    }
  }

}