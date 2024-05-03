import 'package:couple/utils/constant.dart';
import 'package:flutter/material.dart';

class AFloatingActionButtonTheme {
  AFloatingActionButtonTheme._();

  static final lightFloatingActionButtonTheme = FloatingActionButtonThemeData(
    backgroundColor: ColorConstant.primaryColor,
    shape: CircleBorder(),
  );
  static final darkFloatingActionButtonTheme = FloatingActionButtonThemeData(
    backgroundColor: ColorConstant.primaryDarkColor,
    shape: CircleBorder(),
  );
}
