import 'package:couple/models/user_profile_model.dart';
import 'package:couple/providers/app_provider.dart';
import 'package:couple/providers/auth_provider.dart';
import 'package:couple/services/auth_services.dart';
import 'package:couple/services/user_service.dart';
import 'package:couple/themes/theme.dart';
import 'package:couple/utils/logger.dart';
import 'package:couple/utils/route/generator.dart';
import 'package:couple/utils/route/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AppProvider>(
      create: (_) => AppProvider(),
    ),
  ], child: MyApp()));
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Couple.io',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: Provider.of<AppProvider>(context).appTheme,
        darkTheme: AAppTheme.darkTheme,
        initialRoute: routePath.splashScreen,
        onGenerateRoute: RouteGenerator.generateRoute,
        navigatorObservers: [routeObserver],
      ),
    );
  }
}
