import 'package:couple/utils/enums.dart';
import 'package:couple/utils/extensions/enum_to_string.dart';
import 'package:flutter/material.dart';

class SideMenuItem extends StatefulWidget {
  AppRouteName destination;
  String title;
  String? subtitle;
  Icon? leading;
  Color? iconColor;
  Widget? trailing;

  SideMenuItem(
      {super.key,
      this.leading,
      required this.title,
      this.subtitle,
      required this.destination});

  @override
  State<SideMenuItem> createState() => _SideMenuItemState();
}

class _SideMenuItemState extends State<SideMenuItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      selected: widget.destination.enumToString() ==
              ModalRoute.of(context)!.settings.name
          ? true
          : false,
      selectedTileColor: Colors.orange,
      leading: widget.leading,
      trailing: widget.trailing,
      iconColor: widget.iconColor,
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      onTap: () {
        Navigator.popAndPushNamed(context, widget.destination.enumToString());
      },
    );
  }
}
