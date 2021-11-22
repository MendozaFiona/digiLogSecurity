import 'package:digi_logsec/essentials/classed_widget.dart';
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
  }) {
    var sections = Sections(this.context);
    var smallWidgets = SmallWidgets(this.context);
    double containerHeight;
    EdgeInsets containerMargin;
    double upperPad = 40.0 / (upperFlex / 2);

    if (pageType != 'Form' || pageType != 'Scan') {
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
                    if (pageType == 'Scan') QRScanPage(),
                    if (pageType == 'List')
                      Flexible(
                        child: Stack(
                          children: [
                            VisitSearch(),
                            sections.middleSection(
                                title: sectionTitle, pageType: pageType),
                          ],
                        ),
                      ),
                    if (pageType == 'Home' || pageType == 'Form')
                      sections.middleSection(
                        title: sectionTitle,
                        options: options,
                        pageType: pageType,
                        extractedData: extractedData,
                      ),
                  ]),
            ),
          ),
        ),
        Flexible(
            flex: lowerFlex,
            child: Column(children: [
              if (pageType == 'Home') smallWidgets.optionsBtn('Ongoing Visits'),
              if (pageType == 'Scan')
                Expanded(child: sections.lowerSection(option: options)),
            ]))
      ],
    ));
  }
}
