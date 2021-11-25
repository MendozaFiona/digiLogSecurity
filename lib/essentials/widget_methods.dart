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
        _visitorData['vtype'] = vtype.text;
        _visitorData['pnum'] = pnum.text;
      }

      try {
        var res = await addVisitor(_visitorData);

        if (res.message != "Cannot process request. Input errors.") {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Registration Successful")));
          Future.delayed(Duration(seconds: 1), () {
            Navigator.pop(context);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            "The email has already been taken",
            style: TextStyle(color: Color.fromRGBO(239, 224, 187, 1)),
          )));
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "${error.message}",
          style: TextStyle(color: Color.fromRGBO(239, 224, 187, 1)),
        )));
      }
    }
  }

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

  optionResponse(
      {String response, key, method, name, contact, vtype, pnum, purpose}) {
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
