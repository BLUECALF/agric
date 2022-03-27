import 'package:agric/AppController/app_controller.dart';
import 'package:agric/database/database.dart';
import 'package:agric/pages/views/reports_screen.dart';
import 'package:agric/pages/views/trade_screen.dart';
import 'package:agric/styles/text_style.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import "package:flutter/foundation.dart";

class HomeController extends GetxController
{
   final database = Get.find<AppDatabase>();
   final appController = Get.find<AppController>();
   final SalesDao salesDao = Get.put(AppDatabase().salesDao);
  String message ="";


  late List<Xreport>  xreport_list = [
    Xreport(username: appController.username,
        transactions_sold: 0,
        transactions_bought: 0,
        units_sold: 0,
        units_bought: 0)
  ];

  void get_xreport_list() async {
    xreport_list = await database.getXreportList(appController.username);
    print("get xreport was called :: after ");
    print(xreport_list);

    if(xreport_list.isEmpty)
    {
      // insert a new report with 0 as details.
      Xreport x =  Xreport(username:appController.username,transactions_sold: 0, transactions_bought: 0, units_sold: 0, units_bought: 0);
      await database.insertXreport(x);
      xreport_list = await database.getXreportList(appController.username);
    }
    else{
      print(" :: Xreport is NOT emty code called ");
     update();
    }
  }
  Widget render_xreport(List<Xreport> xreport_list)
  {
    if(listEquals(xreport_list,[])==true)
    {return Text("There is No xreport data ");}
    else{return   Card(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.orange[100],

        ),
        child:
        Column(
                children: [
              Center(child: Text("X report",style: MyTextStyle.make("body"),)),
              Text("Transactions sold:${(xreport_list[0]).transactions_sold}"),
              Text("Transactions bought:${(xreport_list[0]).transactions_bought}"),
              Text("Units sold :${xreport_list[0].units_sold}"),
              Text("Units bought : ${xreport_list[0].units_bought}"),
            ],
          ),
        ),
      );}
  }

  Widget render_username()
  {
    return    Card(
      child: Padding(
        padding: const EdgeInsets.all(15),

        child: Row(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("User: ",style: MyTextStyle.make("body"),),
            Text(" ${appController.username.toUpperCase()}",style: MyTextStyle.make("body"),),
          ],
        ),
      ),
    );
  }

 void alert_dialog(String title,String body,context)
  {
    var alertDialog = AlertDialog(
      title: Text("$title"),
      content: Text("$body"),
      actions: [
        TextButton(onPressed: (){Navigator.pop(context);}, child: Text(" ok ")),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) => alertDialog,
      barrierDismissible: false,
    );
  }

  bool confirm_dialog(String title,String body,BuildContext context,Function function)
  {
    var alertDialog = AlertDialog(
      title: Text("$title"),
      content: Text("$body"),
      actions: [
        TextButton(onPressed: (){Get.back();}, child: Text(" no")),
        TextButton(onPressed: (){Get.back(); function();}, child: Text(" yes ")),
      ],

    );
    showDialog(
      context: context,
      builder: (BuildContext context) => alertDialog,
      barrierDismissible: false,
    );
    return false;
  }
  void on_press_of_produce_zreport(BuildContext context) async
  {
  await confirm_dialog("Alert", "Are you sure to produce z report This will reset all X report records", context, (){on_accept_to_produce_zreport();});

  }

  void on_accept_to_produce_zreport() async
  {
    await produce_z_report();  //xreport list should be in observable state
    xreport_list = [Xreport(username: appController.username,
      transactions_bought: 0,
      transactions_sold: 0,
      units_bought: 0,
      units_sold: 0,
    )];
    update();
  }

  produce_z_report() async{

    print("producing Z report");

    //get current x report
    List<Xreport> xreport_list = await database.getXreportList(appController.username);
    Xreport xreport_object = xreport_list[0];

    // make z object
    int zreport_id   = await generate_zreport_id();
    Zreport zreport_object = Zreport(
      date: DateTime.now(),
      transactions_sold: xreport_object.transactions_sold,
      transactions_bought: xreport_object.transactions_bought,
      units_sold: xreport_object.units_sold,
      units_bought: xreport_object.units_bought,
      username: appController.username,
      zreport_id: zreport_id,
    );

    //enter z to database
    int rows = await database.insertZreport(zreport_object);

    if (rows>0)
    {
      // inset of z report was successful.

      //we can now clear the xreport table to zeros
      Xreport new_xreport = Xreport(username: appController.username,
          transactions_sold: 0,
          transactions_bought: 0,
          units_sold: 0,
          units_bought: 0);

      bool updated = await database.updateXreport(new_xreport);

      message = updated?"Production of Z-report Successful":"Production of Z-report failed";
      
      print("Zreport id is $zreport_id \n\n\n");
      message  = await update_sales_and_purchases(zreport_id,message);

      Get.defaultDialog(title: "Z report Info",content: Text("$message"),onConfirm: (){Get.back();});

    }


  }
  Future<String> update_sales_and_purchases(int zreport_id,String message) async
  {
    print("UPDATE SALES AND PURCHASES CALLED ");
    print("uUSERNAME IS :: ${appController.username}");
    // find sales with his username and zreport_id is null
    List<Sale> sales_list =  await salesDao.getSaleList_by_username_and_zreport_id(appController.username);
     Sale sale_obj ;

    List<Purchase> purchase_list =  await database.getPurchaseList_by_username_and_zreport_id(appController.username);
    Purchase purchase_obj;     
     for(int i=0 ;i<sales_list.length ;i++)
       {
         // get the sale object and replace it in database.
         print("Zreport id is $zreport_id");
         sale_obj = Sale(id:sales_list[i].id,date: sales_list[i].date, product: sales_list[i].product, amount_kg: sales_list[i].amount_kg, farmer_number: sales_list[i].farmer_number, username: sales_list[i].username,zreport_id: zreport_id);
         bool affected =  await salesDao.updateSale(sale_obj);
         print("NEw SALE OBJ IS $sale_obj");
         if(!affected) return "Sales update failed";
       }
    for(int i=0 ;i<purchase_list.length ;i++)
    {
      // get the purchase object and replace it in database.
      purchase_obj = Purchase(id:purchase_list[i].id, date: purchase_list[i].date, product: purchase_list[i].product, amount_kg: purchase_list[i].amount_kg, farmer_number: purchase_list[i].farmer_number, username: purchase_list[i].username,zreport_id: zreport_id);
      bool affected =  await database.updatePurchase(purchase_obj);
      print("NEw purchase  OBJ IS $purchase_obj");
      if(!affected) return "Purchase update failed";
    }
    return " Z - report Production success";
  }
  Future<int> generate_zreport_id()
  async{
    List<Zreport> zreport_list = await database.getZreportListAll();
    if(zreport_list.isEmpty)
      {return 1;}
    else
        {
          return (zreport_list[zreport_list.length -1]).zreport_id + 1 ;
        }
  }


  // other methods

  void trade()
  {
    Get.to(()=> TradeScreen());
  }
  void print_reports(context)
  {
    Get.to(()=> ReportsScreen());
  }

  Widget render_button({required IconData icon_name,required Function function,required String text})
  {
    return ElevatedButton(
      child:Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon_name,size: 50,),
            Text("$text",textAlign: TextAlign.center,style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),),
          ]
        ),
      ),
    onPressed:(){function();}
    ,
    );
  }
  void update_xreport() => get_xreport_list();


}