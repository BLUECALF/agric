import 'package:agric/pages/views/home_screen.dart';
import 'package:agric/pages/views/login_screen.dart';
import 'package:agric/pages/views/printing_screen.dart';
import 'package:agric/pages/views/products_screen.dart';
import 'package:agric/pages/views/reports_screen.dart';
import 'package:agric/pages/views/trade_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'database/database.dart';
import 'pages/views/loading_screen.dart';

void main() =>runApp(


    MultiProvider(
      providers: [
        Provider(create: (context) =>AppDatabase(),),
        Provider(create:(_) => AppDatabase().salesDao,)
      ],

      child: GetMaterialApp(
  initialRoute: "/",

  routes: {
      "/":(context) =>LoadingScreen(),
      "/login_screen":(context) => LoginScreen(),
      "/home_screen":(context) =>HomeScreen(),
      "/trade_screen":(context) =>TradeScreen(),
      "/reports_screen":(context) => ReportsScreen(),
       "/products_screen":(context) => ProductsScreen(),
      "/printing_screen":(context) => PrintingScreen(),
  },


),
    ));