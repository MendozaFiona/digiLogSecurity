import 'dart:io';

import 'package:digi_logsec/essentials/pass_arguments.dart';
import 'package:digi_logsec/essentials/sections.dart';
import 'package:digi_logsec/services/visitor_service.dart';
import 'package:flutter/material.dart';
import 'package:digi_logsec/essentials/page_format.dart';

class WidgetMethods extends PageFormat {
  WidgetMethods(BuildContext context) : super(context);

  _register({name, contact, vtype, pnum, purpose}) async {
    var sections = Sections(super.context);
    var formKey = sections.getKey();

    if (formKey.currentState.validate()) {
      Map _visitorData = {
        'name': name.text,
        'contact': contact.text,
        'purpose': purpose.text,
      };

      if (pnum.text != '') {
        _visitorData['vehicle_type'] = vtype.text;
        _visitorData['plate_num'] = pnum.text;
      }

      try {
        final result = await InternetAddress.lookup('example.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          var res = await addVisitor(_visitorData);

          if (res.message != "Cannot process request. Input errors.") {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Entry Added")));
            Future.delayed(Duration(seconds: 1), () {
              Navigator.popUntil(context, ModalRoute.withName('/home'));
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
              "Failed to Save Information. Please try again.",
              style: TextStyle(color: Color.fromRGBO(239, 224, 187, 1)),
            )));
          }
        }
      } on SocketException catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "Failed to connect to the internet.",
          style: TextStyle(color: Color.fromRGBO(239, 224, 187, 1)),
        )));
      }
    }
  }

  static validateForm({label, inputExp, String errResponse = "Invalid Input"}) {
    return (value) {
      //print(value);
      if (value.isEmpty) {
        return "This field is required";
      } else if (inputExp.hasMatch(value) == false) {
        return errResponse;
      }

      if (label == "Contact Number") {
        String contactValue = value[0] + value[1];
        if (value.length > 11 || value.length < 11 || contactValue != '09') {
          return "Invalid contact number";
        }
      } else if (label != 'Plate Number') {
        if (int.tryParse(value[0]) != null) {
          return "Invalid input";
        }
      }

      return null;
    };
  }

  optionResponse(
      {String response,
      String formType,
      key,
      method,
      name,
      contact,
      vtype,
      pnum,
      purpose}) {
    switch (response) {
      case "On Foot":
        {
          Navigator.pushNamed(this.context, '/qr',
              arguments: ScreenArguments(formType: 'OnFoot'));
        }
        break;

      case "Manual Input":
        {
          print(formType);
          if (formType == 'WithVehicle') {
            Navigator.pushNamed(this.context, '/vehicle');
          } else {
            Navigator.pushNamed(this.context, '/foot');
          }
        }
        break;

      case "With Vehicle":
        {
          Navigator.pushNamed(this.context, '/qr',
              arguments: ScreenArguments(formType: 'WithVehicle'));
        }
        break;

      case "OCR":
        {
          Navigator.pushNamed(this.context, '/ocr');
        }
        break;

      case "Enter":
        {
          this._register(
              name: name,
              contact: contact,
              vtype: vtype,
              pnum: pnum,
              purpose: purpose);
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
