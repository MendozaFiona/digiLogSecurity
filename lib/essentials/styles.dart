import 'package:flutter/material.dart';
import 'package:digi_logsec/essentials/page_format.dart';

class Styles extends PageFormat {
  Styles(BuildContext context) : super(context);

  static InputDecoration formStyle(String label) {
    return InputDecoration(
      hintText: label,
      //enabled: enableField,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(25, 24, 81, 1),
          ),
          borderRadius: BorderRadius.circular(10.0)),
      contentPadding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
    );
  }
}
