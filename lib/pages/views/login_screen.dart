
import 'package:agric/pages/controller/login_controller.dart';
import 'package:agric/styles/button_decoration.dart';
import 'package:agric/styles/text_field_decoration.dart';
import 'package:agric/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import '../../database/database.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormBuilderState>();
  final database =  Get.put(AppDatabase());

  @override
  Widget build(BuildContext context) {

    _formKey.currentState?.reset();


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        elevation: 0,
      ),
      backgroundColor: Colors.greenAccent,
      body: Container(
         decoration: BoxDecoration(
           image: DecorationImage(
             image: AssetImage("assets/agriculture.jpg"),
             fit: BoxFit.cover,
           ),
         ),
        child: SafeArea(
          child:Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20,50,20,0),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Log In screen",style: MyTextStyle.make("title-white"),
                  ),
                  SizedBox(height: 20,),
                  FormBuilder(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,

                    child: Column(
                      children: [
                        FormBuilderTextField(name: "username",
                          style: MyTextStyle.make("body"),
                          decoration: MyTextFieldDecoration.make("Enter Username"),
                          cursorColor: Colors.white,
                          cursorWidth: 5,
                          validator:(value)=>LoginController.validate_username(value),
                        ),
                        SizedBox(height: 20,),
                        FormBuilderTextField(name: "password",
                          style: MyTextStyle.make("body"),
                          decoration: MyTextFieldDecoration.make("Enter Password"),
                          cursorColor: Colors.white,
                          obscureText: true,
                          cursorWidth: 5,
                          validator: (value)=>LoginController.validate_password(value),
                        ),
                        SizedBox(height: 20,),
                      ],
                    ),
                  ),

                  TextButton(onPressed:()=> LoginController.validate_login_form(_formKey, context)
                  , child: Text("Log In",style: MyTextStyle.make(""),),style: MyButtonDecoration.make(),),
                ],
              ),
            ),
          ),
        ),
      ),
    );


  }

}


