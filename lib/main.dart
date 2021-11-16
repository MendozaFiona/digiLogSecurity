import 'package:flutter/material.dart';

import 'essentials/page_format.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(scaffoldBackgroundColor: Color.fromRGBO(253, 180, 23, 1)),
    initialRoute: '/',
    routes: {
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
  _ScanQRState createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  @override
  Widget build(BuildContext context) {
    var qrScan = PageFormat(context);

    return Scaffold(
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
      body: onFoot.bodyFormat(
        name: 'Firstname M. Surname',
        upperFlex: 3,
        middleFlex: 11,
        pageType: 'Form',
        sectionTitle: 'On Foot',
      ),
    );
  }
}

class WithVehicle extends StatefulWidget {
  //const WithVehicle({ Key? key }) : super(key: key);

  @override
  _WithVehicleState createState() => _WithVehicleState();
}

class _WithVehicleState extends State<WithVehicle> {
  @override
  Widget build(BuildContext context) {
    var withVehicle = PageFormat(context);

    return Scaffold(
      body: withVehicle.bodyFormat(
        name: 'Firstname M. Surname',
        upperFlex: 3,
        middleFlex: 11,
        pageType: 'Form',
        sectionTitle: 'On Foot',
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
      body: ocrScan.bodyFormat(
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

class OngoingVisits extends StatefulWidget {
  //const OngoingVisits({ Key? key }) : super(key: key);

  @override
  _OngoingVisitsState createState() => _OngoingVisitsState();
}

class _OngoingVisitsState extends State<OngoingVisits> {
  @override
  Widget build(BuildContext context) {
    var ongoingVisit = PageFormat(context);

    return Scaffold(
      body: ongoingVisit.bodyFormat(
        name: 'Firstname M. Surname',
        upperFlex: 3,
        middleFlex: 13,
        pageType: 'List',
        sectionTitle: 'On Foot',
      ),
    );
  }
}
