import 'package:agric/pages/controller/loading_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class LoadingScreen extends GetView{
  final loadingController  = Get.put(LoadingController());
  @override
  Widget build(BuildContext context) {

    loadingController.load_login();

    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SpinKitFoldingCube(
                size: 100.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

}


