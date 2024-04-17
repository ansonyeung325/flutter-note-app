import 'package:flutter/material.dart';

class Loader {
  bool isShow = false;
  BuildContext context;

  Loader({required this.context});

  Future<void> show() async {
    isShow = true;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        });
  }

  Future<void> dismiss() async {
    if (isShow) {
      isShow = false;
      Navigator.of(context).pop();
    }
    return;
  }
}
