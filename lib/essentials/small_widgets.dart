import 'package:flutter/material.dart';
import 'package:digi_logsec/essentials/page_format.dart';
import 'package:digi_logsec/essentials/widget_methods.dart';
import 'package:digi_logsec/essentials/styles.dart';

class SmallWidgets extends PageFormat {
  SmallWidgets(BuildContext context) : super(context);

  ElevatedButton optionsBtn(
    String option, {
    String buttonType,
    double circBorder = 0.0,
    double buttonWidth = 150,
  }) {
    var widgetMethods = WidgetMethods(super.context);
    Color btnColor = Color.fromRGBO(243, 233, 211, 1);
    Color fontColor = Colors.black;
    BorderRadius btnRadius = BorderRadius.circular(40.0);
    Size btnSize = Size(240, 40);

    if (buttonType == "dark") {
      btnColor = Color.fromRGBO(253, 180, 23, 1);
    } else if (buttonType == "blue") {
      btnColor = Color.fromRGBO(25, 24, 81, 1);
      fontColor = Color.fromRGBO(253, 180, 23, 1);
      btnRadius = BorderRadius.circular(circBorder);
      btnSize = Size(buttonWidth, 30);
    }

    return ElevatedButton(
      onPressed: () {
        widgetMethods.optionResponse(response: option);
        /*if (controllerList != null) {
          for (var controller in controllerList) {
            controller.dispose();
          }
        }*/ // delete if not needed
      },
      child: Text(option,
          style: TextStyle(
            fontSize: 18,
            color: fontColor,
            fontFamily: 'Roboto',
          )),
      style: ElevatedButton.styleFrom(
        minimumSize: btnSize,
        primary: btnColor,
        side: BorderSide(color: Colors.black),
        shape: RoundedRectangleBorder(
          borderRadius: btnRadius,
        ),
      ),
    );
  }

  Container visitTile(String name, String code) {
    return Container(
      height: 75,
      decoration: Styles.listStyle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Styles.listFont(),
              ),
              Text(
                code,
                style: Styles.listFont(),
              )
            ],
          ),
          this.optionsBtn('End', buttonType: 'blue', buttonWidth: 70),
        ],
      ),
    );
  }
}
