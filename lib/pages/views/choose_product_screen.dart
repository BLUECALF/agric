
import 'package:agric/pages/controller/choose_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class ChooseProduct extends GetView{
  final ChooseProductController chooseProductController = Get.put(ChooseProductController());
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Choose a Product"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            flex: 1,
            child: GridView.count(
              mainAxisSpacing: 2,
              crossAxisSpacing: 5,
              crossAxisCount: 3,

              children: chooseProductController.render_buttons(),
            ),
          ),
        ],
      ),
    );
  }


}