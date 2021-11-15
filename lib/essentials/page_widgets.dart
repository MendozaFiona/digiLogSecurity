import 'package:flutter/material.dart';

class PageFormat {
  PageFormat();

  static SafeArea bodyFormat(context,
      {String name,
      String sectionTitle,
      List options,
      int upperFlex,
      int middleFlex,
      int lowerFlex,
      String pageType}) {
    return SafeArea(
        child: Column(
      children: [
        Flexible(
            flex: upperFlex,
            child: Container(
              padding: EdgeInsets.only(bottom: 40.0 / (upperFlex / 2)),
              decoration: BoxDecoration(
                color: Color.fromRGBO(25, 24, 81, 1),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(50)),
              ),
              child: Sections.upperSection(name: name, flex: upperFlex),
            )),
        Flexible(
            flex: middleFlex,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              if (pageType != 'Scan')
                Sections.middleSection(
                  context,
                  title: sectionTitle,
                  options: options,
                  pageType: pageType,
                )
            ])),
        Flexible(
            flex: lowerFlex,
            child: Column(children: [
              if (pageType == "Home")
                SmallWidgets.optionsBtn(context, 'Ongoing Visits', 'light'),
              if (pageType == 'Scan')
                Expanded(
                    child: Sections.lowerSection(context, option: options)),
            ]))
      ],
    ));
  }
}

class Sections {
  static Align upperSection({String name, int flex}) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Text(name,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 55 / (flex / 2),
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Nunito',
          )),
    );
  }

  static Container middleSection(context,
      {String title, List options, String pageType}) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.15),
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Nunito',
                )),
            if (pageType == 'Home') optionSection(context, optionList: options),
            if (pageType == 'Form')
              formSection('On Foot'), // change to dynamic later
          ],
        ));
  }

  static Column optionSection(context, {List optionList}) {
    return Column(children: [
      for (var options in optionList)
        SmallWidgets.optionsBtn(context, options.toString(), 'light'),
    ]);
  }

  static Column formSection(String formType) {
    Map txtFieldList;
    final nameCtrlr = TextEditingController();
    // code field isn't required, it is automatically sent to db
    final contactCtrlr = TextEditingController();
    final purposeCtrlr = TextEditingController();

    if (formType == 'On Foot') {
      txtFieldList = {
        nameCtrlr: 'Name',
        contactCtrlr: 'Contact Number',
        purposeCtrlr: 'Purpose'
      };
    }

    return Column(
      children: [
        for (var txtField in txtFieldList.keys)
          SmallWidgets.visitForm(
              fieldController: txtField, label: txtFieldList[txtField]),
      ],
    );
  }

  static Container lowerSection(context, {List option}) {
    return Container(
      //padding: EdgeInsets.only(bottom: 80.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color.fromRGBO(25, 24, 81, 1),
        borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
      ),
      child: Center(
          child: SmallWidgets.optionsBtn(context,
              option.toString().replaceAll(RegExp(r'[^\w\s]+'), ''), 'dark')),
    );
  }
}

class SmallWidgets {
  static ElevatedButton optionsBtn(context, String option, btnType) {
    Color btnColor;

    if (btnType == "light") {
      btnColor = Color.fromRGBO(243, 233, 211, 1);
    } else if (btnType == "dark") {
      btnColor = Color.fromRGBO(253, 180, 23, 1);
    }

    return ElevatedButton(
      onPressed: () {
        WidgetMethods.optionResponse(context, response: option);
      },
      child: Text(option,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontFamily: 'Roboto',
          )),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(240, 40),
        primary: btnColor,
        side: BorderSide(color: Colors.black),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
      ),
    );
  }

  static Column visitForm(
      {TextEditingController fieldController, String label}) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          width: 240,
          height: 40,
          child: TextFormField(
            controller: fieldController,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
            ),
            decoration: Styles.formStyle(label),
          ),
        ),
      ],
    );
  }
}

class WidgetMethods {
  static optionResponse(context, {String response}) {
    switch (response) {
      case "On Foot":
        {
          Navigator.pushNamed(context, '/qr');
          //Navigator.pushNamed(context, '/foot');
        }
        break;

      case "Manual Input":
        {
          Navigator.pushNamed(context, '/foot'); // temporary
        }
        break;

      case "With Vehicle":
        {
          Navigator.pushNamed(context, '/vehicle');
        }
        break;

      case "Ongoing Visits":
        {
          Navigator.pushNamed(context, '/ongoing');
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

class Styles {
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
