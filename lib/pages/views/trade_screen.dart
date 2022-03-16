
import 'package:agric/styles/button_decoration.dart';
import 'package:agric/styles/text_field_decoration.dart';
import 'package:agric/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../../database/database.dart';


class TradeScreen extends StatefulWidget {

  // know the action,
  // enable choosing of iten
  //farmer number
  //size
  // enable submition

  @override
  State<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen> {

  Map previous_data = {};
  Map current_data={};

  String title = "";
  String merchant = "";
  String action ="";
  String message = "";

  final _formKey = GlobalKey<FormBuilderState>();

  late AppDatabase database;
  List<Xreport> xreportList =[];

  List<Buyable_product> buyable_products = [];
  List<Sellable_product> sellable_products =[];




  @override
  Widget build(BuildContext context) {

    database = Provider.of<AppDatabase>(context);


    previous_data = ModalRoute.of(context)?.settings.arguments as Map;

    merchant = previous_data["username"];
    action = previous_data["action"];
    title = (action == "buy_product")? "BUY PRODUCT":"SELL PRODUCT";
    get_data_from_db();









    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        elevation: 0,
      ),
      backgroundColor: Colors.greenAccent,
      body: SafeArea(
        child:Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20,50,20,0),

              child: ListView(
                scrollDirection: Axis.vertical,
                children :[ Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Trade screen ",style: MyTextStyle.make("title"),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      "$title",style: MyTextStyle.make("body"),
                    ),
                    SizedBox(height: 20,),
                    FormBuilder(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,

                      child: Column(
                        children: [
                          FormBuilderDropdown(validator: (value){
                            if(value==null) return "Please Choose a product";
                          }, decoration: MyTextFieldDecoration.make("Choose product"),
                              name: "product",
                              items: get_dropdown_items(),
                          ),
                          SizedBox(height:20),
                          FormBuilderTextField(name: "farmer_number",
                            style: MyTextStyle.make("body"),
                            decoration: MyTextFieldDecoration.make("Farmer number"),
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.number,
                            cursorWidth: 5,
                            validator: (value){
                              if(value == "" || value == null || value.length < 5)
                              {return "Enter Farmer Number";}
                              else{return null;}
                            },
                          ),
                          SizedBox(height: 20,),
                          FormBuilderTextField(name: "amount",
                            style: MyTextStyle.make("body"),
                            decoration: MyTextFieldDecoration.make("Amount in kgs"),
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.number,
                            cursorWidth: 5,
                            validator: (value){
                              if(value == "" || value == null)
                              {return "Enter amount in Kg";}
                              else{return null;}
                            },
                          ),
                          SizedBox(height: 20,),
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
                        message = "$title of ${_formKey.currentState?.fields["product"]?.value} Recorded Successfully";
                        _formKey.currentState?.reset();

                        }
                        else message = "Couldn't Complete action $action";
                        return;

                      });
                      await insert_to_database(action);



                      var alertDialog = AlertDialog(
                        title: Text("$title"),
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
                ),]
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){Navigator.pop(context);},child: Icon(Icons.exit_to_app),),

    );


  }

  insert_to_database(String action) async{

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
                Navigator.pushNamed(context, "/printing_screen",arguments: {
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
                 Navigator.pushNamed(context, "/printing_screen",arguments: {
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
      final salesDao = Provider.of<SalesDao>(context, listen: false);


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
                Navigator.pushNamed(context, "/printing_screen",arguments: {
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
             Navigator.pushNamed(context, "/printing_screen",arguments: {
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
  get_data_from_db() async
  {
    buyable_products = await database.getBuyable_productList();
    sellable_products = await database.getSellable_productList();
    setState(() {
      buyable_products = buyable_products;
      sellable_products = sellable_products;
    });
  }

  List<DropdownMenuItem<String>> get_dropdown_items()
  {


    if(action=="buy_product")
      {


        //check if the list is empty
        if(buyable_products.isEmpty)
        {
          return [DropdownMenuItem(
              child: Card(child: Text("there is no purchasable products"))),];
        }


        List<DropdownMenuItem<String>>  buyable_list = buyable_products.map((obj) {
          return DropdownMenuItem(
            child: Card(
              child:Text("${obj.product_name}",style: MyTextStyle.make("body"),),),value: obj.product_name,);
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
            child: Card(
              child:Text("${obj.product_name}",style: MyTextStyle.make("body"),),),value: obj.product_name,);
        }).toList();
       return sellable_list;
      }

  }





}
