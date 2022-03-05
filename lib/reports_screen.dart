
import 'package:agric/styles/button_decoration.dart';
import 'package:agric/styles/text_field_decoration.dart';
import 'package:agric/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'database/database.dart';




class ReportsScreen extends StatefulWidget {


  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  List<String> giveoutlist  = ["Fertelizer","chicken feed",
    "Cattle Feed","Maize Seed","Pesticide","herbicide"];

  List<String> takeinlist = ["Cows milk","goats milk","Camels Milk","eggs","Tea leaves"];

  List<Sale> salesList =[];
  List<Purchase> purchaseList=[];
  List<Zreport> zreportList=[];

  late AppDatabase database;


  @override
  Widget build(BuildContext context) {

    database = Provider.of<AppDatabase>(context);

    get_objects();

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
                children: [
                  Text(
                    " Reports screen",style: MyTextStyle.make("title"),
                  ),
                  SizedBox(height:10),
                  Text(
                    " Z- reports ",style: MyTextStyle.make("body"),
                  ),
                  SizedBox(height:10),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container( child: Text("Date"),decoration: BoxDecoration(
                          color: Colors.greenAccent,

                        ),),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(child: Text("Transactions sold"),decoration: BoxDecoration(
                          color: Colors.greenAccent,
                        ),),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(child: Text("Units Sold",),decoration: BoxDecoration(
                          color: Colors.greenAccent,
                        ),),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(child: Text("transactions bought",),decoration: BoxDecoration(
                          color: Colors.greenAccent,
                        ),),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(child: Text("Units Bought",),decoration: BoxDecoration(
                          color: Colors.greenAccent,
                        ),),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(child: Text("User Name ",),decoration: BoxDecoration(
                          color: Colors.greenAccent,
                        ),),
                      ),

                    ],
                  ),
                  Column(
                    children: zreportList.map((z) => makerow_of_zreport(z)).toList(),
                  ),
                  SizedBox(height:20),

                  Text(
                    " Purchased Products",style: MyTextStyle.make("body"),
                  ),
                  SizedBox(height:10),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container( child: Text("Product"),decoration: BoxDecoration(
                          color: Colors.greenAccent,

                        ),),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(child: Text("Farmer No"),decoration: BoxDecoration(
                          color: Colors.greenAccent,
                        ),),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(child: Text("amount In kg",),decoration: BoxDecoration(
                          color: Colors.greenAccent,
                        ),),
                      ),

                    ],
                  ),
                  Column(
                    children: purchaseList.map((purchase) => makerow_of_purchase(purchase)).toList(),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    " Sold Products",style: MyTextStyle.make("body"),
                  ),
                  SizedBox(height:10),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(child: Text("Product"),decoration: BoxDecoration(
                          color: Colors.greenAccent,
                        ),),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(child: Text("Farmer No"),decoration: BoxDecoration(
                          color: Colors.greenAccent,
                        ),),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(child: Text("Amount in kg"),decoration: BoxDecoration(
                          color: Colors.greenAccent,
                        ),),
                      ),

                    ],
                  ),
                  Column(
                    children: salesList.map((sales) => makerow_of_sales(sales)).toList(),
                  ),



            ]),),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        setState(() {
          salesList = salesList;
          purchaseList  = purchaseList;
        });

      },child: Icon(Icons.refresh,color: Colors.redAccent[300],),),
    );
  }

  Widget makerow_of_sales(Sale sale)
  {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(child: Text("${sale.product}"),decoration: BoxDecoration(
            color: Colors.grey,
          ),),
        ),
        Expanded(
          flex: 1,
          child: Container(child: Text("${sale.farmer_number}"),decoration: BoxDecoration(
            color: Colors.grey[400],
          ),),
        ),
        Expanded(
          flex: 1,
          child: Container(child: Text("${sale.amount_kg}"),decoration: BoxDecoration(
            color: Colors.grey[300],
          ),),
        ),

      ],

    );
  }

  Widget makerow_of_purchase(Purchase purchase)
  {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(child: Text("${purchase.product}"),decoration: BoxDecoration(
            color: Colors.grey,
          ),),
        ),
        Expanded(
          flex: 1,
          child: Container(child: Text("${purchase.farmer_number}"),decoration: BoxDecoration(
            color: Colors.grey[400],
          ),),
        ),
        Expanded(
          flex: 1,
          child: Container(child: Text("${purchase.amount_kg}"),decoration: BoxDecoration(
            color: Colors.grey[300],
          ),),
        ),

      ],

    );
  }
  get_objects() async
  {
    final salesDao = Provider.of<SalesDao>(context);
    salesList = await salesDao.getSaleList();
    purchaseList = await database.getPurchaseList();
    zreportList = await database.getZreportList();



    // after we get values we recall build by set states
    setState(() {

    });
  }

  // makes row of Z reports

  Widget makerow_of_zreport(Zreport z) {
    return Row(
      children: [

        Expanded(
          flex: 2,
          child: Container(child: Text("${z.date}"), decoration: BoxDecoration(
            color: Colors.grey,
          ),),
        ),
        Expanded(
          flex: 1,
          child: Container(
            child: Text("${z.transactions_sold}"), decoration: BoxDecoration(
            color: Colors.grey[400],
          ),),
        ),
        Expanded(
          flex: 1,
          child: Container(
            child: Text("${z.units_sold}"), decoration: BoxDecoration(
            color: Colors.grey[300],
          ),),
        ),
        Expanded(
          flex: 1,
          child: Container(
            child: Text("${z.transactions_bought}"), decoration: BoxDecoration(
            color: Colors.grey[300],
          ),),
        ),
        Expanded(
          flex: 1,
          child: Container(
            child: Text("${z.units_bought}"), decoration: BoxDecoration(
            color: Colors.grey[300],
          ),),
        ),
        Expanded(
          flex: 1,
          child: Container(
            child: Text("${z.username}"), decoration: BoxDecoration(
            color: Colors.grey[300],
          ),),
        ),

      ],

    );
  }

}
