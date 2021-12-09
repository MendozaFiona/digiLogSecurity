import 'package:digi_logsec/essentials/classed_adding.dart';
import 'package:flutter/material.dart';
import 'package:digi_logsec/essentials/sections.dart';
import 'package:digi_logsec/essentials/small_widgets.dart';

class PageFormat {
  BuildContext context;
  var fullWidth, fullHeight;

  PageFormat(BuildContext context, {setFunction}) {
    this.context = context;
    this.fullWidth = MediaQuery.of(this.context).size.width;
    this.fullHeight = MediaQuery.of(this.context).size.height;
  }

  SafeArea bodyFormat({
    String name,
    String sectionTitle,
    List options,
    int upperFlex,
    int middleFlex,
    int lowerFlex = 0,
    String pageType,
    var extractedData,
    key,
    formType,
  }) {
    var sections = Sections(this.context);
    var smallWidgets = SmallWidgets(this.context);
    double containerHeight;
    EdgeInsets containerMargin;
    double upperPad = 40.0 / (upperFlex / 2);

    if (pageType != 'Form') {
      containerHeight =
          (this.fullHeight / (upperFlex + middleFlex + lowerFlex)) *
                  middleFlex -
              19;
    } else {
      containerMargin = EdgeInsets.symmetric(vertical: (this.fullHeight / 20));
    }

    return SafeArea(
        child: Column(
      children: [
        Flexible(
            flex: upperFlex,
            child: Container(
              padding: EdgeInsets.only(bottom: upperPad),
              decoration: BoxDecoration(
                color: Color.fromRGBO(25, 24, 81, 1),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(50)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Sections.upperSection(name: name, flex: upperFlex),
                ],
              ),
            )),
        Flexible(
          flex: middleFlex,
          child: SingleChildScrollView(
            child: Container(
              margin: containerMargin,
              height: containerHeight,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (pageType == 'Home' || pageType == 'Form')
                      sections.middleSection(
                        title: sectionTitle,
                        options: options,
                        pageType: pageType,
                        extractedData: extractedData,
                        key: key,
                        formType: formType,
                      ),
                  ]),
            ),
          ),
        ),
        if (pageType == 'Form')
          Container(
              height: (this.fullHeight / (upperFlex + middleFlex + lowerFlex)) *
                  lowerFlex,
              child: sections.lowerSection(option: ['Cancel'])),
      ],
    ));
  }

  SafeArea scanFormat({
    String name,
    String sectionTitle,
    List options,
    String pageType,
    int upperFlex,
    int middleFlex,
    int lowerFlex = 0,
    String formType,
    var extractedData,
  }) {
    var sections = Sections(this.context);
    var proportion = this.fullHeight / (upperFlex + middleFlex + lowerFlex);
    double upperPad = 40.0 / (upperFlex / 2);

    return SafeArea(
        child: Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: QRScanPage(formType),
            ),
          ],
        ),
        Positioned(
            top: 0,
            height: proportion * upperFlex,
            width: fullWidth,
            child: Container(
              padding: EdgeInsets.only(bottom: upperPad),
              decoration: BoxDecoration(
                color: Color.fromRGBO(25, 24, 81, 1),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(50)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                      child:
                          Sections.upperSection(name: name, flex: upperFlex)),
                ],
              ),
            )),
        Positioned(
          bottom: 0,
          height: proportion * lowerFlex,
          child: Container(
              child:
                  sections.lowerSection(option: options, formType: formType)),
        ),
      ],
    ));
  }
}
