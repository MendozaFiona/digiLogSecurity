import 'dart:io';

import 'package:digi_logsec/essentials/pass_arguments.dart';
import 'package:digi_logsec/services/visitor_service.dart';
import 'package:flutter/material.dart';
import 'package:digi_logsec/essentials/page_format.dart';

class WidgetMethods extends PageFormat {
  WidgetMethods(BuildContext context) : super(context);

  _register({name, contact, vtype, pnum, destination, key}) async {
    var formKey = key;

    if (formKey.currentState.validate()) {
      Map _visitorData = {
        'name': name.text,
        'contact': contact.text,
        'destination': destination.text,
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
              "Failed to Save Information. Please Recheck Your Input Fields.",
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
      if (value.isEmpty) {
        return "This field is required";
      } else if (inputExp.hasMatch(value) == false) {
        if (label == 'Plate Number' || label == 'Destination') {
          return null;
        } else {
          return errResponse;
        }
      }

      if (label == "Contact Number") {
        String contactValue = value[0] + value[1];
        if (value.length > 11 || value.length < 11 || contactValue != '09') {
          return "Invalid contact number";
        }
      }

      if (label == "Name" || label == "Destination") {
        if (value.length < 3) {
          return "Input too short";
        }
      }

      return null;
    };
  }

  optionResponse({
    String response,
    String formType,
    key,
    method,
    name,
    contact,
    vtype,
    pnum,
    destination,
  }) {
    switch (response) {
      case "On Foot":
        {
          Navigator.pushNamed(this.context, '/qr',
              arguments: ScreenArguments(formType: 'OnFoot'));
        }
        break;

      case "Manual Input":
        {
          if (formType == 'WithVehicle') {
            Navigator.popAndPushNamed(this.context, '/vehicle');
          } else {
            Navigator.popAndPushNamed(this.context, '/foot');
          }
        }
        break;

      case "With Vehicle":
        {
          Navigator.pushNamed(this.context, '/qr',
              arguments: ScreenArguments(formType: 'WithVehicle'));
        }
        break;

      case "Enter":
        {
          this._register(
              name: name,
              contact: contact,
              vtype: vtype,
              pnum: pnum,
              destination: destination,
              key: key);
          //Navigator.pop(this.context, true); // for testing only
        }
        break;

      case "Cancel":
        {
          //Navigator.popAndPushNamed(this.context, '/home');
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/home', (Route<dynamic> route) => false);
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
