import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class AMessageToast extends Fluttertoast {
  static void showToast({
    required String msg,
    Toast toastLength = Toast.LENGTH_LONG,
    ToastGravity gravity = ToastGravity.BOTTOM,
    Color backgroundColor = Colors.grey,
    Color textColor = Colors.black,
    double fontSize = 10,
    timeInSecForIosWeb = 2,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: toastLength,
      gravity: gravity,
      backgroundColor: backgroundColor,
      textColor: textColor,
      timeInSecForIosWeb: timeInSecForIosWeb
    );
  }
}