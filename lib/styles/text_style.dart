import 'package:flutter/material.dart';

class MyTextStyle extends TextStyle {

  static TextStyle make(String purpose)
  {
    if(purpose=="title")
      {
        return TextStyle(

          fontSize: 25,
          fontWeight: FontWeight.bold,
          letterSpacing: 4,
          fontFamily: "Courier Prime",
          color: Colors.black,

        );
      }
    else if(purpose=="body")
    {
      return TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.normal,
        letterSpacing: 2,
        fontFamily: "Courier Prime",
        color: Colors.black,
      );
      }
    else if(purpose=="title-white")
    {
      return TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
        fontFamily: "Courier Prime",
        color: Colors.white,
      );
    }
    else
      {
        return TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          letterSpacing: 2,
          fontFamily: "Courier Prime",
          color: Colors.white,
        );

      }

  }


}
