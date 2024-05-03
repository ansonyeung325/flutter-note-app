import 'package:couple/models/note_model.dart';
import 'package:couple/models/user_profile_model.dart';
import 'package:couple/screens/auth_screen.dart';
import 'package:couple/screens/home_screens.dart';
import 'package:couple/screens/note_screen.dart';
import 'package:couple/screens/profile_screen.dart';
import 'package:couple/screens/setting_screen.dart';
import 'package:couple/screens/splash_screen.dart';
import 'package:couple/utils/logger.dart';
import 'package:couple/utils/route/path.dart';
import 'package:flutter/material.dart';

class RouteGenerator with RouteAware {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arg = settings.arguments;
    switch (settings.name) {
      case RoutePath.splashScreen:
        logger(message: "Current route: ${settings.name}", from: "Router");
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SplashScreen());
      case RoutePath.homeScreen:
        logger(message: "Current route: ${settings.name}", from: "Router");
        return MaterialPageRoute(
            settings: settings, builder: (_) => const HomeScreen());
      case RoutePath.noteScreen:
        logger(message: "Current route: ${settings.name}", from: "Router");
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => NoteScreen(note: arg as NoteModel));
      case RoutePath.authScreen:
        logger(message: "Current route: ${settings.name}", from: "Router");
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AuthScreen());
      case RoutePath.settingScreen:
        logger(message: "Current route: ${settings.name}", from: "Router");
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SettingScreen());
      case RoutePath.profileScreen:
        logger(message: "Current route: ${settings.name}", from: "Router");
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => ProfileScreen(
                  profile: arg as UserProfileModel,
                ));
      default:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ErrorScreen());
    }
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text("Error"),
      ),
    );
  }
}
