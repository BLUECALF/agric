
import 'package:agric/database/database.dart';
import 'package:agric/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ActionsScreen extends StatefulWidget {

  @override
  State<ActionsScreen> createState() => _ActionsScreenState();
}

class _ActionsScreenState extends State<ActionsScreen> {
  Map data ={};
  String message ="";

  late AppDatabase database;
  List<Xreport> xreport_list = [];

  @override
  Widget build(BuildContext context) {

    database = Provider.of<AppDatabase>(context);
    get_objects();


    //get data from login screen
    data = ModalRoute.of(context)?.settings.arguments as Map;

    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title:  Text("Home Page"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/wheat.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(

          children: [
            Column(
              children: [
                //Text(" Activities Page ",style: MyTextStyle.make("title"),),
                SizedBox(height: 20),
                CircleAvatar(backgroundImage: AssetImage("assets/fresh_milk.jpg"),radius: 20,),

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15),

                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("User: ",style: MyTextStyle.make("body"),),
                        Text(" ${data["username"].toString().toUpperCase()}",style: MyTextStyle.make("body"),),

                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(child: Text("X report",style: MyTextStyle.make("body"),)),
                Card(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.orange[100],

                    ),
                    child: Column(
                      children: xreport_list.map((Xreport) => Column(
                        children: [
                          Text("Transactions sold:${Xreport.transactions_sold}"),
                          Text("Transactions bought:${Xreport.transactions_bought}"),
                          Text("Units sold :${Xreport.units_sold}"),
                          Text("Units bought : ${Xreport.units_bought}")
                        ],
                      )).toList(),
                    ),
                  ),
                ),


              ],
            ),
            Expanded(
              flex: 1,
              child: GridView.count(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 2,
                children: [

                  ElevatedButton.icon(icon: Icon(Icons.add_shopping_cart_outlined,size: 50,),onPressed:(){take_product(context);},label: Text("Purchase Product"),),
                  ElevatedButton.icon(icon:Icon(Icons.sell,size :50),onPressed:(){give_product(context);},label: Text(" Sell Product"),),

                  ElevatedButton.icon(icon :Icon(Icons.read_more,size: 50,),onPressed:(){print_reports(context);},label: Text("Print Reports"),),
                  ElevatedButton.icon(icon :Icon(Icons.add,size: 50,),onPressed:(){Navigator.pushNamed(context, "/products_screen");},label: Text("add/remove products"),),


                  ElevatedButton.icon(
                    onPressed: ()async{

                      // get Confirmation to produce report

                      var alertDialog = AlertDialog(
                        title: Text(" Alert"),
                        content: Text("Are You Sure You want to produce Z-report"),
                        actions: [
                          TextButton(onPressed: () async{
                            Navigator.pop(context);
                            // in accepting
                            await produce_z_report();
                            setState(() {
                              xreport_list = [Xreport(id: 0,
                                transactions_bought: 0,
                                transactions_sold: 0,
                                units_bought: 0,
                                units_sold: 0,
                              )];

                              var alertDialog = AlertDialog(
                                title: Text("Z Report Production"),
                                content: Text("$message"),
                                actions: [
                                  TextButton(onPressed: (){Navigator.pop(context);}, child: Text(" Yes")),

                                ],

                              );
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => alertDialog,
                                barrierDismissible: false,
                              );

                            });



                            }, child: Text(" Yes")),
                          TextButton(onPressed: (){Navigator.pop(context);}, child: Text(" No "))
                        ],

                      );
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => alertDialog,
                        barrierDismissible: false,
                      );





                    },
                    label: Text("Produce Z Report "),
                    icon:Icon(Icons.print),
                  ),

                ],
              ),
            ),








            ]),
      ),

      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.pop(context);
      },child: Icon(Icons.logout,size: 50,color: Colors.redAccent,),
      backgroundColor: Colors.white,

      ),

    );
  }

  void take_product(context)
  {
    Navigator.pushNamed(context, "/trade_screen",arguments: {
      "username":data["username"],
      "action":"buy_product"
    });
  }

  void give_product(context)
  {
    Navigator.pushNamed(context, "/trade_screen" ,arguments: {
      "username":data["username"],
      "action":"sell_product"
    });
  }
  void print_reports(context)
  {
    Navigator.pushNamed(context, "/reports_screen");
  }

  void get_objects() async {

    xreport_list = await database.getXreportList();

    if(xreport_list.isEmpty)
      {
        // insert a new report with 0 as details.
        Xreport x =  Xreport(id:0,transactions_sold: 0, transactions_bought: 0, units_sold: 0, units_bought: 0);
        await database.insertXreport(x);
        xreport_list = await database.getXreportList();
      }
    setState(() {
      xreport_list = xreport_list;
    });

  }

  produce_z_report() async{
    print("producing Z report");

    //get current x report
    List<Xreport> xreport_list = await database.getXreportList();
    Xreport xreport_object = xreport_list[0];

    // make z object
    Zreport zreport_object = Zreport(
      date: DateTime.now(),
      transactions_sold: xreport_object.transactions_sold,
      transactions_bought: xreport_object.transactions_bought,
      units_sold: xreport_object.units_sold,
      units_bought: xreport_object.units_bought,
      username: data["username"],
    );

    int rows = await database.insertZreport(zreport_object);

    if (rows>0)
      {
        // inset of z report was successful.

        //we can now clear the xreport table to zeros
        Xreport new_xreport = Xreport(id: 0,
            transactions_sold: 0,
            transactions_bought: 0,
            units_sold: 0,
            units_bought: 0);

        bool updated = await database.updateXreport(new_xreport);

        message = updated?"Production of Z-report Successful":"Production of Z-report failed";


      }


    //enter z to database
    //reset values of x report.


  }



}
