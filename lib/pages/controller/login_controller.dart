import 'package:agric/database/database.dart';
import 'package:agric/pages/views/home_screen.dart';
import "package:flutter/material.dart";
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class LoginController extends GetxController
{
  final database =  Get.find<AppDatabase>();


   static Future<bool> verify_login_details(String username,String password) async
  {
    print("Current date is ");
    print(DateTime.now());
    var now = DateTime.now();
    final _dayFormater = DateFormat('d');
    final _monthFormater = DateFormat('M');
    final _yearFormater = DateFormat('y');

    var date = "${_dayFormater.format(now)}-${_monthFormater.format(now)}-${_yearFormater.format(now)}";

    print(" date is $date");

    return true;
  }

  static String? validate_username(String? value)
   {
   if(value == "" || value == null)
   {return "Enter Username";}
   else{return null;}
   }

   static String? validate_password(String? value)
   {
     if (value == "" || value == null) {
       return "Enter Password";
     }
     else {
       return null;
     }
   }

   static validate_login_form(GlobalKey<FormBuilderState> _formKey,BuildContext context) async
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
        Get.to(()=> HomeScreen(),arguments: data);
       }
       else{
         alert_dialog("error", "username and password you entered is wrong", context);
       }

     }}

  static void alert_dialog(String title,String body,context)
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