import 'package:digi_logsec/essentials/classed_widget.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'essentials/page_format.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(scaffoldBackgroundColor: Color.fromRGBO(253, 180, 23, 1)),
    initialRoute: '/',
    routes: {
      //'/': (context) => QRScanTest(),
      '/': (context) => Dashboard(),
      '/qr': (context) => ScanQR(),
      '/foot': (context) => OnFoot(),
      '/vehicle': (context) => WithVehicle(),
      '/ocr': (context) => ScanOCR(),
      '/ongoing': (context) => OngoingVisits(),
    },
  ));
}

class LoginPage extends StatefulWidget {
  //const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Dashboard extends StatelessWidget {
  //const Dashboard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dashboard = PageFormat(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: dashboard.bodyFormat(
        name: 'Firstname M. Surname',
        sectionTitle: 'Add Visitors',
        options: [
          'On Foot',
          'With Vehicle',
        ],
        upperFlex: 2,
        middleFlex: 3,
        lowerFlex: 1,
        pageType: "Home",
      ),
    );
  }
}

class ScanQR extends StatefulWidget {
  //const ScanQR({ Key? key }) : super(key: key);

  @override
  ScanQRState createState() => ScanQRState();
}

class ScanQRState extends State<ScanQR> {
  @override
  Widget build(BuildContext context) {
    var qrScan = PageFormat(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: qrScan.bodyFormat(
        name: 'Firstname M. Surname',
        options: ['Manual Input'],
        upperFlex: 3,
        middleFlex: 11,
        lowerFlex: 2,
        pageType: 'Scan',
      ),
    );
  }
}

class OnFoot extends StatefulWidget {
  //const OnFoot({ Key? key }) : super(key: key);

  @override
  _OnFootState createState() => _OnFootState();
}

class _OnFootState extends State<OnFoot> {
  @override
  Widget build(BuildContext context) {
    var onFoot = PageFormat(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: onFoot.bodyFormat(
        name: 'Firstname M. Surname',
        upperFlex: 3,
        middleFlex: 11,
        pageType: 'Form',
        sectionTitle: "Visitor's Details",
      ),
    );
  }
}

class WithVehicle extends StatefulWidget {
  //const WithVehicle({ Key? key }) : super(key: key);

  @override
  WithVehicleState createState() => WithVehicleState();
}

class WithVehicleState extends State<WithVehicle> {
  @override
  Widget build(BuildContext context) {
    var withVehicle = PageFormat(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: withVehicle.bodyFormat(
        name: 'Firstname M. Surname',
        upperFlex: 3,
        middleFlex: 11,
        pageType: 'Form',
        sectionTitle: "Visitor's Details",
      ),
    );
  }
}

class ScanOCR extends StatefulWidget {
  //const ScanOCR({ Key? key }) : super(key: key);

  @override
  _ScanOCRState createState() => _ScanOCRState();
}

class _ScanOCRState extends State<ScanOCR> {
  @override
  Widget build(BuildContext context) {
    var ocrScan = PageFormat(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ocrScan.bodyFormat(
        name: 'Firstname M. Surname',
        options: ['Back'],
        upperFlex: 3,
        middleFlex: 11,
        lowerFlex: 2,
        pageType: 'Scan',
      ),
    );
  }
}

class OngoingVisits extends StatefulWidget {
  //const OngoingVisits({ Key? key }) : super(key: key);

  @override
  OngoingVisitsState createState() => OngoingVisitsState();
}

class OngoingVisitsState extends State<OngoingVisits> {
  FloatingSearchBarController visitSearchController;
  String selectedTerm;

  @override
  Widget build(BuildContext context) {
    var ongoingVisit = PageFormat(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ongoingVisit.bodyFormat(
        name: 'Firstname M. Surname',
        upperFlex: 3,
        middleFlex: 13,
        pageType: 'List',
        sectionTitle: "Ongoing Visits",
      ),
    );
  }
}
