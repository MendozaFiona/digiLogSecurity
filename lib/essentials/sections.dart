import 'package:flutter/material.dart';
import 'package:digi_logsec/essentials/page_format.dart';
import 'package:digi_logsec/essentials/small_widgets.dart';

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

  Center middleSection(
      {String title = 'title here', List options, String pageType}) {
    double sectionMargin = 0;

    if (pageType == 'List') {
      sectionMargin = 70;
    }

    return Center(
      child: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.symmetric(vertical: sectionMargin),
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
            )),
      ),
    );
  }

  Column optionSection({List optionList}) {
    var smallWidgets = SmallWidgets(super.context);
    return Column(children: [
      for (var options in optionList)
        smallWidgets.optionsBtn(options.toString(), buttonType: 'light'),
    ]);
  }

  Column formSection(String formType) {
    Map txtFieldList;
    var smallWidgets = SmallWidgets(super.context);
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
          SmallWidgets.formField(
              fieldController: txtField, label: txtFieldList[txtField]),
        SizedBox(
          height: 10,
        ),
        smallWidgets.optionsBtn('ENTER', buttonType: 'blue')
      ],
    );
  }

  Container formBottomSection() {
    var smallWidgets = SmallWidgets(super.context);
    return Container(
        padding: EdgeInsets.only(top: 40.0),
        width: super.fullWidth / 1.5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            smallWidgets.optionsBtn('Back',
                buttonType: 'blue', circBorder: 40.0, buttonWidth: 100),
            smallWidgets.optionsBtn('OCR',
                buttonType: 'blue', circBorder: 40.0, buttonWidth: 100)
          ],
        ));
  }

  Container lowerSection({List option}) {
    var smallWidgets = SmallWidgets(super.context);
    return Container(
      //padding: EdgeInsets.only(bottom: 80.0),
      width: super.fullWidth,
      decoration: BoxDecoration(
        color: Color.fromRGBO(25, 24, 81, 1),
        borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
      ),
      child: Center(
          child: smallWidgets.optionsBtn(
              option.toString().replaceAll(RegExp(r'[^\w\s]+'), ''),
              buttonType: 'dark')),
    );
  }
}
