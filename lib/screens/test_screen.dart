import 'package:couple/utils/components/general_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget{
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _StateTestScreen();
}

class _StateTestScreen extends State<TestScreen> {


  @override
  Widget build(BuildContext context) {
    return GeneralLayout(
      widgetChild: Container(),
    );
  }

}