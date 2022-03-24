
import 'package:agric/database/database.dart';
import 'package:agric/pages/controller/home_controller.dart';
import 'package:agric/pages/views/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_screen.dart';

class HomeScreen extends StatelessWidget{

final HomeController  homeController =  Get.put(HomeController());


  @override
  Widget build(BuildContext context) {
    homeController.get_xreport_list();
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
                homeController.render_username(),
                SizedBox(height: 20),

                StreamBuilder(
                  stream: homeController.database.getXreportListStream(homeController.appController.username),
                    builder: (context , snapshot)
                    {
                      print("snaphot  data is ");
                      print(snapshot.data);
                      if(snapshot.hasError)
                        {return Text("Error in X report data,${snapshot.toString()}");}
                      List<Xreport> xreport_list  = snapshot.data as List<Xreport>;
                      return homeController.render_xreport(xreport_list);
                    }
                ),

              ],
            ),
            Expanded(
             flex: 1,
              child: GridView.count(
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    crossAxisCount: 3,

                children: [
                  homeController.render_button(icon_name:Icons.add_shopping_cart, function:(){homeController.trade();} , text: "Purchase / Sell Product"),
                  homeController.render_button(icon_name:Icons.computer, function:(){} , text: "Connect to server"),
                  homeController.render_button(icon_name:Icons.read_more, function:(){homeController.print_reports(context);} , text: "Print Reports"),
                  homeController.render_button(icon_name:Icons.add, function:(){Get.to(ProductsScreen());} , text: "add/remove products"),
                  homeController.render_button(icon_name:Icons.print, function:(){homeController.on_press_of_produce_zreport(context);} , text: "Produce Z Report "),
                  homeController.render_button(icon_name:Icons.refresh, function:(){homeController.update_xreport();} , text: " Update X report"),

                ],
              ),
            ),
            ]),
      ),

      floatingActionButton: FloatingActionButton(onPressed: () { Get.off(LoginScreen());
      },child: Icon(Icons.logout,size: 50,color: Colors.redAccent,),
      backgroundColor: Colors.white,
      ),
    );
  }

}
