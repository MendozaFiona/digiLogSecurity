import 'package:flutter/material.dart';
import 'package:digi_logsec/essentials/page_format.dart';

class Styles extends PageFormat {
  Styles(BuildContext context) : super(context);

  static TextStyle listFont() {
    return TextStyle(
      fontSize: 16,
      color: Colors.black,
      fontFamily: 'Nunito',
    );
  }

  static BoxDecoration listStyle() {
    return BoxDecoration(
      color: Color.fromRGBO(243, 233, 211, 1),
      borderRadius: BorderRadius.all(Radius.circular(10)),
      border: Border.all(
        color: Colors.black,
      ),
    );
  }

  static InputDecoration formStyle(String label) {
    double conPadding = 1;

    if (label == 'Destination') {
      conPadding = 20;
    }
    return InputDecoration(
      hintText: label,
      helperText: '',
      //enabled: enableField,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(25, 24, 81, 1),
          ),
          borderRadius: BorderRadius.circular(10.0)),
      contentPadding: EdgeInsets.symmetric(horizontal: 1, vertical: conPadding),
    );
  }
}
