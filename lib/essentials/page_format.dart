import 'package:flutter/material.dart';
import 'package:digi_logsec/essentials/sections.dart';
import 'package:digi_logsec/essentials/small_widgets.dart';

class PageFormat {
  BuildContext context;
  var fullWidth, fullHeight;

  PageFormat(BuildContext context) {
    this.context = context;
    this.fullWidth = MediaQuery.of(this.context).size.width;
    this.fullHeight = MediaQuery.of(this.context).size.height;
  }

  SafeArea bodyFormat(
      {String name,
      String sectionTitle,
      List options,
      int upperFlex,
      int middleFlex,
      int lowerFlex = 0,
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
            child: SingleChildScrollView(
              child: Container(
                height:
                    (this.fullHeight / (upperFlex + middleFlex + lowerFlex)) *
                        middleFlex,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (pageType != 'Scan')
                        sections.middleSection(
                          title: sectionTitle,
                          options: options,
                          pageType: pageType,
                        ),
                      if (pageType == 'Form') sections.formBottomSection()
                    ]),
              ),
            )),
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
