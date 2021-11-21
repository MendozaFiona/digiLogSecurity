import 'dart:io';

import 'package:digi_logsec/essentials/pass_arguments.dart';
import 'package:flutter/material.dart';
import 'package:digi_logsec/main.dart';

import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanPage extends ScanQR {
  //const QRScanPage({ Key? key }) : super(key: key);

  @override
  _QRScanPageState createState() => _QRScanPageState();
}

class _QRScanPageState extends ScanQRState {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController controller;
  Barcode barcode;
  int counter = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  passResult() {
    counter += 1;
    //final args = ModalRoute.of(context).settings.arguments as ScreenArguments;
    if (barcode != null && counter >= 1) {
      Future.delayed(Duration.zero, () {
        Navigator.pushNamed(context, '/foot',
            arguments: ScreenArguments(barcode.code));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    passResult();

    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(this.context).size.height * 0.66,
      child: Stack(
        children: [
          buildQrView(context),
        ],
      ),
    );
  }

  @override
  void reassemble() async {
    super.reassemble();

    if (Platform.isAndroid) {
      await controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
          cutOutSize: MediaQuery.of(context).size.width * 0.75,
          borderWidth: 10,
          borderLength: 20,
          borderRadius: 10,
          borderColor: Colors.white,
        ),
      );

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;

      controller.scannedDataStream.listen((barcode) {
        setState(() {
          this.barcode = barcode;
        });
      });
    });
  }
}

class VisitSearch extends OngoingVisits {
  @override
  _VisitSearchState createState() => _VisitSearchState();
}

class _VisitSearchState extends OngoingVisitsState {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FloatingSearchBar(
        controller: visitSearchController,
        hint: 'Search',
        onSubmitted: (query) {
          setState(() {
            selectedTerm = query;
          });
          visitSearchController.close();
        },
        actions: [
          FloatingSearchBarAction.searchToClear(),
        ],
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
                color: Colors.white,
                elevation: 4.0,
                child: Builder(builder: (context) {
                  return Column(mainAxisSize: MainAxisSize.min, children: []);
                })),
          );
        },
      ),
    );
  }
}
