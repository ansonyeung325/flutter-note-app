import 'package:couple/providers/app_provider.dart';
import 'package:couple/providers/auth_provider.dart';
import 'package:couple/screens/home_screens.dart';
import 'package:couple/themes/theme.dart';
import 'package:couple/utils/route/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'auth_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getUserStatus();
  }

  Future<void> getUserStatus() async {
    await Future.delayed(const Duration(seconds: 3)).then((_) {
      final authState = Provider.of<AuthProvider>(context, listen: false);
      final appState = Provider.of<AppProvider>(context, listen: false);
      bool isDarkMode =
          SchedulerBinding.instance.platformDispatcher.platformBrightness ==
              Brightness.dark;
      if (isDarkMode) {
        appState.setTheme(AAppTheme.darkTheme);
      }
      authState.getCurrentUser();
      if (authState.isLoggedIn) {
        Navigator.pushReplacementNamed(context, routePath.homeScreen);
      } else {
        Navigator.pushReplacementNamed(context, routePath.authScreen);
      }
    });
  }

  Widget _splashBody() {
    return Center(
      child: Container(
        child: Lottie.asset('assets/lottieFile/splash_gif.json'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthProvider>(context);

    return Scaffold(body: _splashBody());
  }
}
