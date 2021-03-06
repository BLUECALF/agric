import 'package:gradient_ui_widgets/gradient_ui_widgets.dart' as a;
import 'package:agric/styles/gradient_colors.dart';
import 'package:agric/pages/controller/login_controller.dart';
import 'package:agric/styles/button_decoration.dart';
import 'package:agric/styles/text_field_decoration.dart';
import 'package:agric/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import '../../database/database.dart';

class LoginScreen extends GetView{

  final _formKey = GlobalKey<FormBuilderState>();
  final database =  Get.find<AppDatabase>();
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {

    _formKey.currentState?.reset();

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: Get.height,
          child: a.GradientCard(
            gradient: g1,
            child: SafeArea(
              child:Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20,50,20,0),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${loginController.appController.appname}",style: MyTextStyle.make("title-white"),
                      ),
                      SizedBox(height: 20,),
                      CircleAvatar(
                        backgroundColor: Colors.lightGreenAccent,
                        backgroundImage: AssetImage("assets/cow_w_mlk.png"),
                        radius: 70,
                      ),
                      SizedBox(height: 10,),
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
                              validator:(value)=>loginController.validate_username(value),
                            ),
                            SizedBox(height: 20,),
                            FormBuilderTextField(name: "password",
                              style: MyTextStyle.make("body"),
                              decoration: MyTextFieldDecoration.make("Enter Password"),
                              cursorColor: Colors.white,
                              obscureText: true,
                              cursorWidth: 5,
                              validator: (value)=>loginController.validate_password(value),
                            ),
                            SizedBox(height: 20,),
                          ],
                        ),
                      ),

                      Container(
                        width: double.infinity,
                        child: a.GradientElevatedButton(
                          gradient: g3,
                          onPressed:()=> loginController.validate_login_form(_formKey, context)
                        , child: Text("Log In",style: MyTextStyle.make("body-white"),),style: MyButtonDecoration.make(),),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

  }

}


