import 'dart:async';
import "package:agric/server_connection/password_hasher.dart";
import 'package:agric/AppController/app_controller.dart';
import 'package:agric/database/database.dart';
import 'package:agric/pages/views/home_screen.dart';
import 'package:agric/server_connection/server_connection.dart';
import "package:flutter/material.dart";
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'dart:io';




class LoginController extends GetxController
{
  final database =  Get.find<AppDatabase>();
  final appController =  Get.find<AppController>();
  final serverConn = Get.find<ServerConnection>();
  late String date;



   String? validate_username(String? value)
   {
   if(value == "" || value == null)
   {return "Enter Username";}
   else{return null;}
   }

    String? validate_password(String? value)
   {
     if (value == "" || value == null) {
       return "Enter Password";
     }
     else {
       return null;
     }
   }

    validate_login_form(GlobalKey<FormBuilderState> _formKey,BuildContext context) async
   {
     var validate = _formKey.currentState?.validate();
     if(validate==true) {
       _formKey.currentState?.save();
       var data = _formKey.currentState!.value;
       print(data);
       //on correct details proceed to other screen

       // feed Details to app controller before loging in
       appController.username = data["username"];
       appController.password = data["password"];
       //check if user is offline

       bool offline  = await is_offline();
       if(offline)
         {
            Get.defaultDialog(title:"Offline"
          , textConfirm: "use offline details",content: Text("You are offline, connect to internet."),
          textCancel: "cancel",
          onConfirm: (){
              login_with_offline_details();
              Get.back();Get.back();},
          onCancel: (){Get.back();Get.back();}
              );
           return;
         }
       Get.defaultDialog(title:"" ,
         barrierDismissible: true,
         content: Column(
           children: [
             SpinKitRing(
               color: Colors.lightGreenAccent,
             ),
             Text("If it loads longer\n"
                 "Please \nCheck your internet connection"),
           ],
         ),
       );

       bool accepted = await serverConn.connect_to_server();
       Get.back();
       Get.back();
       if (accepted == true) {
         var hashed_pass = hash_password(appController.password);
         try{await database.insertUser(User(username: appController.username, password: hashed_pass));}
         catch(_){}

         Get.off(()=> HomeScreen(),);
        // update app conroller
         appController.current_date = DateTime.now();
       }
       else{
         alert_dialog("Error", "username and password you entered is wrong", context);
       }

     }}

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

  Future<bool> is_offline()  async {
    // add a spiner to show progress
    Get.defaultDialog(title:"" ,
      barrierDismissible: true,
      content: Column(
        children: [
          Text("Connecting to server"),
          SpinKitRing(
            color: Colors.lightGreenAccent,
          ),
        ],
      ),
    );
    try {
      final result = await InternetAddress.lookup('example.com').timeout(Duration(seconds: 3));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        print(result.toString());
        return false;
      }
      else {return true;}
    } on SocketException catch (_) {
      print('not connected');
      return true;
    }
    on TimeoutException catch (_) {
      print('not connected');
      return true;
    }

  }

  void login_with_offline_details() async{
     List<User> userlist =  await database.getUserList();
     if(userlist.length == 0)
       {
         Get.defaultDialog(title:"Notice"
             , textConfirm: "ok",content: Text("No offline record matching ur details"),
             onConfirm: (){Get.back();Get.back();}
         );
         return;
       }

     for(int i=0;i<userlist.length;i++)
       {
         if(userlist[i].username == appController.username
             && userlist[i].password == hash_password(appController.password))
           {
             // details are correct ... login
             Get.off(()=> HomeScreen(),);
           }
         else
           {
             Get.defaultDialog(title:"Notice"
                 , textConfirm: "ok",content: Text("No offline record matching ur details"),
                 onConfirm: (){Get.back();Get.back();}
             );
           }
       }
  }

}