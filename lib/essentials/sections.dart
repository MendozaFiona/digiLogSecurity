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

  Center middleSection({
    String title = 'Title Here',
    List options,
    String pageType,
    var extractedData,
  }) {
    double sectionMargin = 0;

    if (pageType == 'List') {
      sectionMargin = 70;
    }

    return Center(
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  formSection(
                      extractedData: extractedData), // change to dynamic later
                if (pageType == 'List') listSection(),
              ],
            ),
          )),
    );
  }

  Column optionSection({List optionList}) {
    var smallWidgets = SmallWidgets(super.context);
    return Column(children: [
      for (var options in optionList)
        smallWidgets.optionsBtn(options.toString(), buttonType: 'light'),
    ]);
  }

  Container listSection() {
    // get map from db this is temporary
    Map ongoingVisitList = {
      'Test Name 1': 'Test Code 1',
      'Test Name 2': 'Test Code 2',
      'Test Name 3': 'Test Code 3'
    };

    var smallWidgets = SmallWidgets(super.context);

    return Container(
      padding: EdgeInsets.only(top: 15),
      width: this.fullWidth / 1.5,
      child: Column(
        children: [
          for (var ongoingVisitItem in ongoingVisitList.keys)
            Column(
              children: [
                smallWidgets.visitTile(
                    ongoingVisitItem, ongoingVisitList[ongoingVisitItem]),
                SizedBox(
                  height: 10,
                )
              ],
            ),
        ],
      ),
    );
  }

  Column formSection({var extractedData}) {
    Map txtFieldList;
    String formType = this.context.toString().split('(').first;

    var smallWidgets = SmallWidgets(super.context);

    final nameCtrlr = TextEditingController(text: extractedData);
    // code field isn't required, it is automatically sent to db
    final contactCtrlr = TextEditingController();
    final vehicleTypeCtrlr = TextEditingController();
    final plateNumCtrlr = TextEditingController();
    final purposeCtrlr = TextEditingController();

    if (formType == 'OnFoot') {
      txtFieldList = {
        nameCtrlr: 'Name',
        contactCtrlr: 'Contact Number',
        purposeCtrlr: 'Purpose'
      };
    }

    if (formType == 'WithVehicle') {
      txtFieldList = {
        nameCtrlr: 'Name',
        contactCtrlr: 'Contact Number',
        vehicleTypeCtrlr: 'Type of Vehicle',
        plateNumCtrlr: 'Plate Number',
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
        smallWidgets.optionsBtn('ENTER', buttonType: 'blue'),
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
