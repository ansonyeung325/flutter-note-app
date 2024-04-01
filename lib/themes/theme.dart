import 'package:couple/themes/custom_themes/drawer_theme.dart';
import 'package:couple/themes/custom_themes/elevated_button_theme.dart';
import 'package:couple/themes/custom_themes/text_form_field_theme.dart';
import 'package:flutter/material.dart';

import 'custom_themes/text_theme.dart';

class AAppTheme {
  AAppTheme._(); //To avoid create instances

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.light,
      primaryColor: Colors.yellow,
      primaryColorLight: Colors.grey[100],
      primaryColorDark: Colors.grey[900],
      scaffoldBackgroundColor: Colors.white,
      textTheme: ATextTheme.lightTextTheme,
      elevatedButtonTheme: AElevatedButtonTheme.lightElevatedButtonTheme,
      inputDecorationTheme: ATextFormFieldTheme.lightTextFormFieldTheme,
      drawerTheme: ADrawerTheme.lightDrawerTheme);

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.dark,
      primaryColor: Colors.yellow,
      primaryColorLight: Colors.grey[900],
      primaryColorDark: Colors.black,
      scaffoldBackgroundColor: Colors.black,
      textTheme: ATextTheme.darkTextTheme,
      elevatedButtonTheme: AElevatedButtonTheme.darkElevatedButtonTheme,
      inputDecorationTheme: ATextFormFieldTheme.darkTextFormFieldTheme,
      drawerTheme: ADrawerTheme.darkDrawerTheme);
}
