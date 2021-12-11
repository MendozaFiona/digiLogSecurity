import 'package:digi_logsec/essentials/classed_adding.dart';
import 'package:flutter/material.dart';
import 'package:digi_logsec/essentials/page_format.dart';
import 'package:digi_logsec/essentials/small_widgets.dart';

class Sections extends PageFormat {
  Sections(BuildContext context) : super(context);

  static Align upperSection({String name, int flex, double fSize}) {
    if (fSize == null) {
      fSize = 55 / (flex / 2);
    }

    return Align(
      alignment: Alignment.bottomCenter,
      child: Text(name,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Nunito',
          )),
    );
  }

  Center middleSection(
      {String title = 'Title Here',
      List options,
      String pageType,
      var extractedData,
      key,
      formType}) {
    double sectionMargin = 0;
    double sectionHeight;

    if (formType == 'WithVehicle') {
      sectionHeight = fullHeight * 0.6;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: sectionHeight,
              margin: EdgeInsets.only(top: sectionMargin),
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
                      FormSection(
                        extractedData: extractedData,
                        formType: formType,
                        formKey: key,
                      ), // change to dynamic later
                    if (pageType == 'List') listSection(),
                  ],
                ),
              )),
        ],
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

  Container formBottomSection({name, contact, vtype, pnum, destination, key}) {
    var smallWidgets = SmallWidgets(super.context);

    return Container(
        width: super.fullWidth / 1.5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment
              .center, // should be spaceBetween if have OCR btn
          children: [
            /*smallWidgets.optionsBtn('OCR',
                buttonType: 'blue', circBorder: 40.0, buttonWidth: 100),*/ //return when done with other functions!!!
            smallWidgets.optionsBtn(
              'Enter',
              buttonType: 'blue',
              circBorder: 40.0,
              buttonWidth: 100,
              name: name,
              contact: contact,
              vtype: vtype,
              pnum: pnum,
              destination: destination,
              key: key,
            )
          ],
        ));
  }

  Container lowerSection({List option, String formType}) {
    var smallWidgets = SmallWidgets(super.context);

    return Container(
      //padding: EdgeInsets.only(bottom: 80.0),
      width: super.fullWidth,
      decoration: BoxDecoration(
        color: Color.fromRGBO(25, 24, 81, 1),
        borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
      ),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (var optionSelected in option)
            smallWidgets.optionsBtn(
                optionSelected.toString().replaceAll(RegExp(r'[^\w\s]+'), ''),
                buttonType: 'dark',
                formType: formType),
        ],
      )),
    );
  }
}
