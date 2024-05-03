import 'package:cloud_firestore_platform_interface/cloud_firestore_platform_interface.dart';
import 'package:couple/models/setting_model.dart';
import 'package:couple/models/user_profile_model.dart';
import 'package:couple/providers/app_provider.dart';
import 'package:couple/providers/auth_provider.dart';
import 'package:couple/screens/home_screens.dart';
import 'package:couple/services/user_service.dart';
import 'package:couple/themes/theme.dart';
import 'package:couple/utils/enums.dart';
import 'package:couple/utils/route/path.dart';
import 'package:couple/widgets/side_menu.dart';
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
    final authState = Provider.of<AuthProvider>(context, listen: false);
    final appState = Provider.of<AppProvider>(context, listen: false);
    await authState.getCurrentUser();
    bool isDarkMode =
        SchedulerBinding.instance.platformDispatcher.platformBrightness ==
            Brightness.dark;

    if (isDarkMode) {
      appState.setTheme(AAppTheme.darkTheme);
    }

    if (authState.isLoggedIn) {
      Navigator.pushReplacementNamed(context, RoutePath.homeScreen);
    } else {
      Navigator.pushReplacementNamed(context, RoutePath.authScreen);
    }
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
    return Scaffold(drawer: const SideMenu(), body: _splashBody());
  }
}
