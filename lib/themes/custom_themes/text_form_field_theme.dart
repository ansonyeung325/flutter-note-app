import 'package:flutter/material.dart';

class ATextFormFieldTheme {
  ATextFormFieldTheme._();

  static final lightTextFormFieldTheme = InputDecorationTheme(
      fillColor: Colors.black.withOpacity(0.2),
      suffixIconColor: Colors.grey,
      prefixIconColor: Colors.grey,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
      hintStyle: TextStyle().copyWith(fontSize: 14, color: Colors.white),
      labelStyle: TextStyle().copyWith(fontSize: 14, color: Colors.grey),
      border: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 1.0, color: Colors.grey[300]!)),
      errorBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(width: 1.0, color: Colors.redAccent)),
      focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(width: 1.0, color: Colors.grey[600]!)));

  static final darkTextFormFieldTheme = InputDecorationTheme(
      fillColor: Colors.grey[900],
      suffixIconColor: Colors.grey,
      prefixIconColor: Colors.grey,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
      hintStyle: TextStyle().copyWith(fontSize: 14, color: Colors.grey),
      labelStyle: TextStyle().copyWith(fontSize: 14, color: Colors.grey),
      border: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 1.0, color: Colors.grey[300]!)),
      errorBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(width: 1.0, color: Colors.redAccent)),
      focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(width: 1.0, color: Colors.grey[600]!))
  );
}
