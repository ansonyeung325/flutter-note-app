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
      case routePath.splashScreen:
        logger(message: "Current route: ${settings.name}", from: "Router");
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SplashScreen());
      case routePath.homeScreen:
        logger(message: "Current route: ${settings.name}", from: "Router");
        return MaterialPageRoute(
            settings: settings, builder: (_) => const HomeScreen());
      case routePath.noteScreen:
        logger(message: "Current route: ${settings.name}", from: "Router");
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => NoteScreen(content: arg as String));
      case routePath.authScreen:
        logger(message: "Current route: ${settings.name}", from: "Router");
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AuthScreen());
      case routePath.settingScreen:
        logger(message: "Current route: ${settings.name}", from: "Router");
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SettingScreen());
      case routePath.profileScreen:
        logger(message: "Current route: ${settings.name}", from: "Router");
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ProfileScreen());
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
