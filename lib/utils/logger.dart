import 'package:flutter/cupertino.dart';

void logger({String? from, required String message}) {
  debugPrint(from != null ? "[$from] $message" : message);
}
