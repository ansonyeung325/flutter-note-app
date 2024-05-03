import 'package:couple/themes/custom_themes/bottom_app_bar_theme.dart';
import 'package:couple/themes/custom_themes/drawer_theme.dart';
import 'package:couple/themes/custom_themes/elevated_button_theme.dart';
import 'package:couple/themes/custom_themes/floating_action_button_theme.dart';
import 'package:couple/themes/custom_themes/text_form_field_theme.dart';
import 'package:flutter/material.dart';

import 'custom_themes/text_theme.dart';

class AAppTheme {
  AAppTheme._(); //To avoid create instances

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.light,
      primaryColor: const Color(0xffFFE03F),
      primaryColorLight: const Color(0xffFFF500),
      primaryColorDark: const Color(0xffFDB700),
      scaffoldBackgroundColor: const Color(0xFFEAEAEA),
      bottomAppBarTheme: ABottomAppBarTheme.lightBottomAppBarTheme,
      floatingActionButtonTheme:
          AFloatingActionButtonTheme.lightFloatingActionButtonTheme,
      textTheme: ATextTheme.lightTextTheme,
      elevatedButtonTheme: AElevatedButtonTheme.lightElevatedButtonTheme,
      inputDecorationTheme: ATextFormFieldTheme.lightTextFormFieldTheme,
      drawerTheme: ADrawerTheme.lightDrawerTheme);

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.dark,
      primaryColor: const Color(0xffFFE03F),
      primaryColorLight: const Color(0xffFFF500),
      primaryColorDark: const Color(0xffFDB700),
      scaffoldBackgroundColor: const Color(0xFFEAEAEA),
      bottomAppBarTheme: ABottomAppBarTheme.darkBottomAppBarTheme,
      floatingActionButtonTheme:
          AFloatingActionButtonTheme.darkFloatingActionButtonTheme,
      textTheme: ATextTheme.darkTextTheme,
      elevatedButtonTheme: AElevatedButtonTheme.darkElevatedButtonTheme,
      inputDecorationTheme: ATextFormFieldTheme.darkTextFormFieldTheme,
      drawerTheme: ADrawerTheme.darkDrawerTheme);
}
