import 'package:agric/AppController/app_controller.dart';
import 'package:agric/database/database.dart';
import 'package:agric/pages/views/home_screen.dart';
import "package:flutter/material.dart";
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';



class LoginController extends GetxController
{
  final database =  Get.find<AppDatabase>();
  final appController =  Get.find<AppController>();
  late String date;


    Future<bool> verify_login_details(String username,String password) async
  {
    print("Current date is ");
    print(DateTime.now());
    var now = DateTime.now();
    final _dayFormater = DateFormat('d');
    final _monthFormater = DateFormat('M');
    final _yearFormater = DateFormat('y');

    date = "${_dayFormater.format(now)}-${_monthFormater.format(now)}-${_yearFormater.format(now)}";

    print(" date is $date");

    return true;
  }

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

       bool accepted = await verify_login_details(
           data["username"], data["password"]);

       if (accepted == true) {
        Get.off(()=> HomeScreen(),);
        // update app conroller
         appController.username = data["username"];
         appController.current_date = DateTime.now();
       }
       else{
         alert_dialog("error", "username and password you entered is wrong", context);
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

}