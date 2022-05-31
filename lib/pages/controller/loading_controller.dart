
import 'package:agric/database/database.dart';
import 'package:agric/AppController/app_controller.dart';
import 'package:agric/pages/views/login_screen.dart';
import 'package:get/get.dart';

import '../../server_connection/server_connection.dart';


class LoadingController extends GetxController{
  void load_login() async
  {
    final database =  Get.put(AppDatabase());
    final appController = Get.put(AppController());
    final serverConn = Get.put(ServerConnection());
    await Future.delayed(Duration(seconds: 4));
      //Navigator.pushReplacementNamed(context, "/login_screen");
    Get.off(() => LoginScreen());
  }
}
