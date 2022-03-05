import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void _load_login(context)
  async
  {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacementNamed(context, "/login_screen");
  }

  @override
  void initState() {
    // TODO: implement initState
    _load_login(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

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


