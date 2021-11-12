import 'package:flutter/material.dart';

class PageFormat {
  PageFormat();

  static SafeArea bodyFormat(
      {String name,
      String sectionTitle,
      List options,
      int upperFlex,
      int middleFlex,
      int lowerFlex,
      String pageType,
      context}) {
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
              child: Sections.upperContent(name: name, flex: upperFlex),
            )),
        Flexible(
            flex: middleFlex,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              if (sectionTitle != null)
                Sections.optionContainer(
                  title: sectionTitle,
                  options: options,
                )
            ])),
        Flexible(
            flex: lowerFlex,
            child: Column(children: [
              if (options != null) OptionButtons.optionsBtn('Ongoing Visits'),
              if (pageType == 'Scan')
                Expanded(child: Sections.lowerOption(context)),
            ]))
      ],
    ));
  }
}

class Sections {
  static Align upperContent({name, flex}) {
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

  static Container optionContainer({title, options}) {
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
            Sections.optionSection(optionList: options),
          ],
        ));
  }

  static Column optionSection({optionList}) {
    return Column(children: [
      for (var options in optionList)
        OptionButtons.optionsBtn(options.toString()),
    ]);
  }

  static Container lowerOption(context) {
    return Container(
      //padding: EdgeInsets.only(bottom: 80.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color.fromRGBO(25, 24, 81, 1),
        borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
      ),
      child: Center(child: Text('Testing')),
    );
  }
}

class OptionButtons {
  static ElevatedButton optionsBtn(options) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(options,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontFamily: 'Roboto',
          )),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(240, 40),
        primary: Color.fromRGBO(243, 233, 211, 1),
        side: BorderSide(color: Colors.black),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
      ),
    );
  }
}
