
import 'package:agric/pages/controller/trade_controller.dart';
import 'package:agric/pages/views/home_screen.dart';
import 'package:agric/styles/button_decoration.dart';
import 'package:agric/styles/text_field_decoration.dart';
import 'package:agric/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class TradeScreen extends GetView{

  // know the action,
  // enable choosing of iten
  //farmer number
  //size
  // enable submition
 final TradeController tradeController = Get.put(TradeController());
  final _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    tradeController.get_previous_data();
    tradeController.get_data_from_db();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title:Text("Trade screen "),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.green,
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
                    Text("${tradeController.title} ",style: MyTextStyle.make("body"),),
                    SizedBox(height: 10,),
                    Text("Choose Transaction",style: MyTextStyle.make("body"),),


                GetBuilder<TradeController>(builder: (_){ return FormBuilder(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,

                      child: Column(
                        children: [
                          tradeController.render_transactions(_formKey,textEditingController),
                          //FormBuilderRadioGroup(name: "hi", options: [FormBuilderFieldOption(value: "hi")]),
                          SizedBox(height:20),
                          Container(
                            width: double.infinity,
                            child: TextButton(onPressed:(){ tradeController.on_press_choose_product(textEditingController);
                            }, child: Text("Choose a Product",style: MyTextStyle.make("body-white"),),style: MyButtonDecoration.make(),),
                          ),

                          SizedBox(height:20),
                          FormBuilderTextField(name: "product",
                            style: MyTextStyle.make("body"),
                            decoration: MyTextFieldDecoration.make("Chosen product"),
                            controller: textEditingController,
                            readOnly: true,
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.number,
                            cursorWidth: 5,
                            validator: (value){
                              if(value == "" || value == null)
                              {return "Enter chosen Product";}
                              else{return null;}
                            },
                          ),
                          SizedBox(height:20),

                       /*   FormBuilderDropdown(validator: (value){
                            if(value==null) return "Please Choose a product";
                          }, decoration: MyTextFieldDecoration.make("Choose product"),
                              name: "product",
                              items: tradeController.get_dropdown_items(),
                          ),*/
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
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 2),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(20),
                                ),
                              ),
                              hintText: " Quantity",
                              suffix: Card(child: Text("KGs" ,style: MyTextStyle.make("body"),)),
                            ),
                            cursorColor: Colors.black,
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

                    Container(
                      width: double.infinity,
                      child: TextButton(onPressed:() async{
                        tradeController.on_press_submit(_formKey,textEditingController);
                      }, child: Text("Post",style: MyTextStyle.make("body-white"),),style: MyButtonDecoration.make(),),
                    ),
                    SizedBox(height:20),
                  ],
                ),]
              ),
            ),
          ),
        ),
      ),

    );

  }
}
