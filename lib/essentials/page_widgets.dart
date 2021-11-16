import 'package:flutter/material.dart';

class PageFormat {
  BuildContext context;

  PageFormat(BuildContext context) {
    this.context = context;
  }

  set setContext(BuildContext context) {
    //print(context);

    this.context = context;
    print(this.context);
  }

  BuildContext get getContext {
    return context;
  }

  SafeArea bodyFormat(
      {String name,
      String sectionTitle,
      List options,
      int upperFlex,
      int middleFlex,
      int lowerFlex,
      String pageType}) {
    var sections = Sections(this.context);
    var smallWidgets = SmallWidgets(this.context);

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
                sections.middleSection(
                  title: sectionTitle,
                  options: options,
                  pageType: pageType,
                )
            ])),
        Flexible(
            flex: lowerFlex,
            child: Column(children: [
              if (pageType == "Home")
                smallWidgets.optionsBtn('Ongoing Visits', 'light'),
              if (pageType == 'Scan')
                Expanded(child: sections.lowerSection(option: options)),
            ]))
      ],
    ));
  }
}

class Sections extends PageFormat {
  Sections(BuildContext context) : super(context);

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

  Container middleSection({String title, List options, String pageType}) {
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
            if (pageType == 'Home') optionSection(optionList: options),
            if (pageType == 'Form')
              formSection('On Foot'), // change to dynamic later
          ],
        ));
  }

  Column optionSection({List optionList}) {
    var smallWidgets = SmallWidgets(super.context);
    return Column(children: [
      for (var options in optionList)
        smallWidgets.optionsBtn(options.toString(), 'light'),
    ]);
  }

  Column formSection(String formType) {
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
        //smallWidgets.optionsBtn(context, option, btnType);
      ],
    );
  }

  Container lowerSection({List option}) {
    var smallWidgets = SmallWidgets(super.context);
    return Container(
      //padding: EdgeInsets.only(bottom: 80.0),
      width: MediaQuery.of(this.context).size.width,
      decoration: BoxDecoration(
        color: Color.fromRGBO(25, 24, 81, 1),
        borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
      ),
      child: Center(
          child: smallWidgets.optionsBtn(
              option.toString().replaceAll(RegExp(r'[^\w\s]+'), ''), 'dark')),
    );
  }
}

class SmallWidgets extends PageFormat {
  SmallWidgets(BuildContext context) : super(context);

  ElevatedButton optionsBtn(String option, btnType) {
    Color btnColor;
    var widgetMethods = WidgetMethods(super.context);

    if (btnType == "light") {
      btnColor = Color.fromRGBO(243, 233, 211, 1);
    } else if (btnType == "dark") {
      btnColor = Color.fromRGBO(253, 180, 23, 1);
    }

    return ElevatedButton(
      onPressed: () {
        widgetMethods.optionResponse(response: option);
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

class WidgetMethods extends PageFormat {
  WidgetMethods(BuildContext context) : super(context);

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

      default:
        {
          return;
        }
        break;
    }
  }
}

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
