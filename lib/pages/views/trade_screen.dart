
import 'package:agric/pages/controller/trade_controller.dart';
import 'package:agric/styles/button_decoration.dart';
import 'package:agric/styles/text_field_decoration.dart';
import 'package:agric/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class TradeScreen extends StatelessWidget {

  // know the action,
  // enable choosing of iten
  //farmer number
  //size
  // enable submition
 final TradeController tradeController = Get.put(TradeController());
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    tradeController.get_previous_data();
    tradeController.get_data_from_db();

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
                      "${tradeController.title}",style: MyTextStyle.make("body"),
                    ),
                    SizedBox(height: 20,),

                GetBuilder<TradeController>(builder: (_){ return FormBuilder(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,

                      child: Column(
                        children: [
                          FormBuilderDropdown(validator: (value){
                            if(value==null) return "Please Choose a product";
                          }, decoration: MyTextFieldDecoration.make("Choose product"),
                              name: "product",
                              items: tradeController.get_dropdown_items(),
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
                    );}), //-- end of form builder

                    TextButton(onPressed:() async{
                      tradeController.on_press_submit(_formKey);

                    }, child: Text("Submit",style: MyTextStyle.make(""),),style: MyButtonDecoration.make(),),
                  ],
                ),]
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){Get.back();},child: Icon(Icons.exit_to_app),),

    );

  }










}
