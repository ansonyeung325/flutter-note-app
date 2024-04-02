import 'package:couple/utils/enums.dart';

extension RouteNameExtension on AppRouteName {
  String enumToString() {
    switch (this) {
      case AppRouteName.homeScreen:
        return "/";
      case AppRouteName.authScreen:
        return "/auth";
      case AppRouteName.noteScreen:
        return "/note";
      case AppRouteName.profileScreen:
        return "/profile";
      case AppRouteName.settingScreen:
        return "/setting";
      default:
        return "";
    }
  }
}