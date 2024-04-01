import 'package:couple/providers/auth_provider.dart';
import 'package:couple/services/auth_services.dart';
import 'package:couple/utils/route/path.dart';
import 'package:couple/widgets/side_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GeneralLayout extends StatelessWidget {
  final Widget widgetChild;
  final Widget? bottomSheet;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBar;
  const GeneralLayout(
      {super.key,
      required this.widgetChild,
      this.appBar,
      this.bottomNavigationBar,
      this.bottomSheet,
      this.floatingActionButton});

  final EdgeInsetsGeometry screenPadding =
      const EdgeInsets.symmetric(horizontal: 12);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authProvider, child) {
      return Scaffold(
          floatingActionButton: floatingActionButton,
          bottomNavigationBar: bottomNavigationBar,
          bottomSheet: bottomSheet,
          drawer: const SideMenu(),
          extendBodyBehindAppBar: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: appBar ??
              AppBar(
                  automaticallyImplyLeading: true,
                  backgroundColor: Colors.transparent,
                  scrolledUnderElevation: 0,
                  elevation: 0),
          body: widgetChild);
    });
  }
}
