import 'package:flutter/material.dart';
import 'package:digi_logsec/essentials/page_format.dart';

class WidgetMethods extends PageFormat {
  WidgetMethods(BuildContext context) : super(context);

  static validateForm({inputExp, String errResponse = "Invalid Input"}) {
    return (value) {
      if (value.isEmpty) {
        return "This field is required";
      } else if (inputExp.hasMatch(value) == false) {
        return errResponse;
      }

      return null;
    };
  }

  optionResponse({String response}) {
    switch (response) {
      case "On Foot":
        {
          Navigator.pushNamed(this.context, '/qr');
          //Navigator.pushNamed(context, '/foot');
        }
        break;

      case "Manual Input":
        {
          Navigator.pushNamed(this.context, '/foot'); // temporary
        }
        break;

      case "With Vehicle":
        {
          Navigator.pushNamed(this.context, '/vehicle');
        }
        break;

      case "Ongoing Visits":
        {
          Navigator.pushNamed(this.context, '/ongoing');
        }
        break;

      case "OCR":
        {
          Navigator.pushNamed(this.context, '/ocr');
        }
        break;

      case "Enter":
        {
          //Navigator.pop(this.context, true); // for testing only
        }
        break;

      default:
        {
          return;
        }
        break;
    }
  }
}
