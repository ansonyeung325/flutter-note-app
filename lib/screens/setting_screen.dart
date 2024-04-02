import 'package:couple/providers/app_provider.dart';
import 'package:couple/providers/auth_provider.dart';
import 'package:couple/utils/route/path.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _StateSettingScreen();
}

class _StateSettingScreen extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget settingRow(
      {required Widget leading,
      required String title,
      required Function(bool) func,
      required bool value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            leading,
            const SizedBox(
              width: 12,
            ),
            Text(title, style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
        Switch(activeColor: Colors.yellow, value: value, onChanged: func)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppProvider>(context, listen: false);
    final authState = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
        extendBodyBehindAppBar: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text(
            "Setting",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          automaticallyImplyLeading: true,
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                settingRow(
                    leading: const Icon(Icons.dark_mode_outlined),
                    title: 'Dark Mode',
                    value: appState.isDarkMode,
                    func: (value) {
                      setState(() {
                        appState.toggleTheme();
                        debugPrint("${appState.appTheme.primaryColor}");
                      });
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side: BorderSide(color: Colors.orange)))),
                        onPressed: () {
                          authState.signOut();
                          Navigator.pushReplacementNamed(context, routePath.authScreen);
                        },
                        child: Row(
                          children: [
                            Text(
                              "Signout",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Icon(Icons.logout_outlined,color: Theme.of(context).primaryColorDark,)
                          ],
                        ))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
