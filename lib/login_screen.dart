
import 'package:agric/styles/button_decoration.dart';
import 'package:agric/styles/text_field_decoration.dart';

import 'package:agric/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'database/database.dart';


class LoginScreen extends StatefulWidget {


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late AppDatabase database;

  final _formKey = GlobalKey<FormBuilderState>();


  @override
  Widget build(BuildContext context) {
    _formKey.currentState?.reset();

    database = Provider.of<AppDatabase>(context);

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
                          validator: (value){
                          if(value == "" || value == null)
                            {return "Enter Username";}
                          else{return null;}
                          },
                        ),
                        SizedBox(height: 20,),
                        FormBuilderTextField(name: "password",
                          style: MyTextStyle.make("body"),
                          decoration: MyTextFieldDecoration.make("Enter Password"),
                          cursorColor: Colors.white,
                          obscureText: true,
                          cursorWidth: 5,
                          validator: (value){
                            if(value == "" || value == null)
                            {return "Enter Password";}
                            else{return null;}
                          },
                        ),
                        SizedBox(height: 20,),
                      ],
                    ),
                  ),

                  TextButton(onPressed:() async{
                    setState(() async{
                      var validate = _formKey.currentState?.validate();

                      if(validate==true)
                        { _formKey.currentState?.save();
                        var data = _formKey.currentState!.value;
                        print(data);

                        //on correct details proceed to other screen


                        bool accepted =  await verify_password(data["username"],data["password"]);

                         if(accepted==true)
                           {
                             Navigator.pushNamed(context, "/actions_screen",arguments: data);
                           }
                         else
                           {

                             setState(() {

                               var alertDialog = AlertDialog(
                                 title: Text("Error"),
                                 content: Text("Username or password you Entered is wrong "),
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



                             });

                           }

                       }
                    });
                  }, child: Text("Log In",style: MyTextStyle.make(""),),style: MyButtonDecoration.make(),),




                ],
              ),
            ),
          ),
        ),
      ),
    );


  }
 Future<bool> verify_password(String username,String password) async
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

}


