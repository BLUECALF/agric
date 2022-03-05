import 'package:agric/actions_screen.dart';
import 'package:agric/login_screen.dart';
import 'package:agric/printing_screen.dart';
import 'package:agric/products_screen.dart';
import 'package:agric/reports_screen.dart';
import 'package:agric/trade_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'database/database.dart';
import 'loading_screen.dart';

void main() =>runApp(

    MultiProvider(
      providers: [
        Provider(create: (context) =>AppDatabase(),),
        Provider(create:(_) => AppDatabase().salesDao,)
      ],

      child: MaterialApp(
  initialRoute: "/",

  routes: {
      "/":(context) =>LoadingScreen(),
      "/login_screen":(context) => LoginScreen(),
      "/actions_screen":(context) =>ActionsScreen(),
      "/trade_screen":(context) =>TradeScreen(),
      "/reports_screen":(context) => ReportsScreen(),
       "/products_screen":(context) => ProductsScreen(),
      "/printing_screen":(context) => PrintingScreen(),
  },


),
    ));