import 'package:flutter/material.dart';

import 'essentials/page_format.dart';
import 'essentials/pass_arguments.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(scaffoldBackgroundColor: Color.fromRGBO(253, 180, 23, 1)),
    initialRoute: '/home',
    routes: {
      '/home': (context) => Dashboard(),
      '/qr': (context) => ScanQR(),
      '/foot': (context) => OnFoot(),
      '/vehicle': (context) => WithVehicle(),
    },
  ));
}

class Dashboard extends StatelessWidget {
  //const Dashboard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dashboard = PageFormat(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: dashboard.bodyFormat(
        name: 'USTP Digital Logbook',
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
  get formType => null;

  //const ScanQR({ Key? key }) : super(key: key);

  @override
  ScanQRState createState() => ScanQRState();
}

class ScanQRState extends State<ScanQR> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as ScreenArguments;
    var qrScan = PageFormat(context);

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: qrScan.scanFormat(
          name: 'QR Code Scan',
          options: ['Cancel', 'Manual Input'],
          upperFlex: 3,
          middleFlex: 11,
          lowerFlex: 2,
          pageType: 'Scan',
          formType: args.formType,
        ),
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
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var usercode;
    final args = ModalRoute.of(context).settings.arguments as ScreenArguments;

    if (args != null) {
      usercode = args.code.split(',').last;
    }

    var onFoot = PageFormat(context);

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: onFoot.bodyFormat(
          name: 'Visitor On Foot',
          upperFlex: 3,
          middleFlex: 11,
          lowerFlex: 2,
          pageType: 'Form',
          sectionTitle: "Visitor's Details",
          extractedData: usercode,
          key: _formKey,
          formType: "OnFoot",
        ),
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
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var usercode;
    final args = ModalRoute.of(context).settings.arguments as ScreenArguments;

    if (args != null) {
      usercode = args.code.split(',').last;
    }

    var withVehicle = PageFormat(context);

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: withVehicle.bodyFormat(
          name: 'Visitor with Vehicle',
          upperFlex: 3,
          middleFlex: 11,
          lowerFlex: 2,
          pageType: 'Form',
          sectionTitle: "Visitor's Details",
          extractedData: usercode,
          key: _formKey,
          formType: "WithVehicle",
        ),
      ),
    );
  }
}
