
import 'package:agric/pages/views/login_screen.dart';
import 'package:get/get.dart';


class LoadingController {
  static void load_login(context) async
  {
    await Future.delayed(Duration(seconds: 4));
      //Navigator.pushReplacementNamed(context, "/login_screen");
    Get.off(() => LoginScreen());
  }
}
