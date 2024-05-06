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
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final PreferredSizeWidget? appBar;
  final bool showBottomNavigationBar;
  const GeneralLayout(
      {super.key,
      required this.widgetChild,
      this.appBar,
      this.bottomSheet,
      this.floatingActionButton,
      this.showBottomNavigationBar = true,
      this.bottomNavigationBar});

  final EdgeInsetsGeometry screenPadding =
      const EdgeInsets.symmetric(horizontal: 12);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: showBottomNavigationBar
            ? bottomNavigationBar ??
                BottomAppBar(
                  height: Theme.of(context).bottomAppBarTheme.height,
                  color: Theme.of(context).bottomAppBarTheme.color,
                  child: Row(
                    children: [],
                  ),
                )
            : null,
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
  }
}
