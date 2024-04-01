import 'package:couple/main.dart';
import 'package:couple/providers/app_provider.dart';
import 'package:couple/providers/auth_provider.dart';
import 'package:couple/screens/setting_screen.dart';
import 'package:couple/utils/enums.dart';
import 'package:couple/widgets/side_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthProvider>(context);

    return Drawer(
      backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              SizedBox(
                height: 120,
                width: double.infinity,
                child: Row(
                  children: [
                    const Icon(Icons.code_off),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Text(
                        "Overcode.io",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    )
                  ],
                ),
              ),
              SideMenuItem(title: "Home", destination: AppRouteName.homeScreen),
              SideMenuItem(title: "Test", destination: AppRouteName.testScreen),
              SideMenuItem(title: "Setting", destination: AppRouteName.settingScreen),
              const Spacer(),
              Container(
                height: 80,
                padding: const EdgeInsets.all(8.0),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                    borderRadius: const BorderRadius.all(Radius.circular(6))),
                child: Row(
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 40,
                        child: (authState.getProfile?.profileImage != null)
                            ? null
                            : const Icon(Icons.perm_identity_outlined)),
                    const SizedBox(width: 20),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${authState.getProfile?.username}",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          "${authState.getProfile?.email}",
                          style: Theme.of(context).textTheme.labelLarge,
                        )
                      ],
                    ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}