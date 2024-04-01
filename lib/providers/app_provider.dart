import 'package:couple/models/user_profile_model.dart';
import 'package:couple/themes/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AppProvider with ChangeNotifier {
  ThemeData _appTheme = AAppTheme.lightTheme;
  bool isDarkMode = false;

  void setTheme(ThemeData themeData) {
    _appTheme = themeData;
    if(_appTheme == AAppTheme.darkTheme){
      isDarkMode = true;
    }
    notifyListeners();
  }

  void toggleTheme() {
    if (_appTheme == AAppTheme.darkTheme) {
      _appTheme = AAppTheme.lightTheme;
      isDarkMode = false;
    } else {
      _appTheme = AAppTheme.darkTheme;
      isDarkMode = true;
    }
    notifyListeners();
  }

  ThemeData get appTheme => _appTheme;

}
