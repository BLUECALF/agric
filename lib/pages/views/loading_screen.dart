import 'package:agric/pages/controller/loading_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    LoadingController.load_login(context);

    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpinKitChasingDots(
              size: 100.0,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

}


