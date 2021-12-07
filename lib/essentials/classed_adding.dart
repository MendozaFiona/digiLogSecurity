import 'dart:io';

import 'package:digi_logsec/essentials/pass_arguments.dart';
import 'package:digi_logsec/essentials/sections.dart';
import 'package:digi_logsec/essentials/styles.dart';
import 'package:digi_logsec/essentials/widget_methods.dart';
import 'package:flutter/material.dart';
import 'package:digi_logsec/main.dart';
import 'package:flutter/services.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

class FormSection extends StatefulWidget {
  final extractedData;
  final formType;
  final formKey;
  const FormSection({Key key, this.extractedData, this.formType, this.formKey})
      : super(key: key);

  @override
  _FormSectionState createState() => _FormSectionState();
}

class _FormSectionState extends State<FormSection> {
  final nameCtrlr = TextEditingController();
  final contactCtrlr = TextEditingController();
  final vehicleTypeCtrlr = TextEditingController();
  final plateNumCtrlr = TextEditingController();
  final purposeCtrlr = TextEditingController();

  check() {
    nameCtrlr.dispose();
    contactCtrlr.dispose();
    vehicleTypeCtrlr.dispose();
    plateNumCtrlr.dispose();
    purposeCtrlr.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sections = Sections(context);

    final formKey = widget.formKey;

    @override
    void dispose() {
      check();
      super.dispose();
    }

    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomFormField(
            fieldController: nameCtrlr,
            label: 'Name',
            extractedData: widget.extractedData,
          ),
          CustomFormField(
              fieldController: contactCtrlr, label: 'Contact Number'),
          if (widget.formType == 'WithVehicle')
            CustomFormField(
                fieldController: vehicleTypeCtrlr, label: 'Vehicle Type'),
          if (widget.formType == 'WithVehicle')
            CustomFormField(
                fieldController: plateNumCtrlr, label: 'Plate Number'),
          CustomFormField(fieldController: purposeCtrlr, label: 'Purpose'),
          SizedBox(
            height: 10,
          ),
          sections.formBottomSection(
              name: nameCtrlr,
              contact: contactCtrlr,
              vtype: vehicleTypeCtrlr,
              pnum: plateNumCtrlr,
              purpose: purposeCtrlr,
              key: formKey)
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomFormField extends StatefulWidget {
  //const FormField({ Key? key }) : super(key: key);
  String label;
  String extractedData;
  final fieldController;

  CustomFormField(
      {Key key, this.fieldController, this.label, this.extractedData})
      : super(key: key);

  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  var btnEditable = true;
  @override
  Widget build(BuildContext context) {
    if (widget.label == 'Name' && widget.extractedData != null) {
      widget.fieldController.text = widget.extractedData;
      btnEditable = false;
    }
    TextInputType fieldType = TextInputType.text;
    double fieldHeight = 60;
    int length = 40;
    int lines = 1;
    var exp = RegExp(r"^[a-z A-Z,.\-]+$");

    if (widget.label == 'Purpose') {
      fieldHeight = 100;
      length = 100;
      lines = 2;
    } else if (widget.label == 'Contact Number') {
      fieldType = TextInputType.phone;
      length = 11;
      exp = RegExp(r"^[0-9]*$");
    }

    return Column(
      children: [
        Container(
            width: 230,
            height: 20,
            alignment: Alignment.center,
            child: Align(
                alignment: Alignment.centerLeft, child: Text(widget.label))),
        Container(
          width: 240,
          height: fieldHeight,
          child: TextFormField(
            enabled: btnEditable,
            validator: WidgetMethods.validateForm(
              inputExp: exp,
              label: widget.label,
            ),
            controller: widget.fieldController,
            textAlign: TextAlign.center,
            keyboardType: fieldType,
            inputFormatters: [LengthLimitingTextInputFormatter(length)],
            maxLines: lines,
            style: TextStyle(
              fontSize: 18.0,
            ),
            decoration: Styles.formStyle(widget.label),
          ),
        ),
      ],
    );
  }
}

class QRScanPage extends ScanQR {
  //const QRScanPage({ Key? key }) : super(key: key);
  final formType;

  QRScanPage(this.formType);

  @override
  _QRScanPageState createState() => _QRScanPageState(formType: formType);
}

class _QRScanPageState extends ScanQRState {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController controller;
  Barcode barcode;
  bool alreadyPassed;
  var formType;

  _QRScanPageState({this.formType});

  @override
  initState() {
    super.initState();
    alreadyPassed = false;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  passResult(_formType) {
    if (barcode != null) {
      if (alreadyPassed == false) {
        alreadyPassed = true;
        Future.delayed(Duration.zero, () async {
          var nav;
          if (formType == "WithVehicle") {
            nav = await Navigator.pushNamed(context, '/vehicle',
                arguments: ScreenArguments(code: barcode.code));
          } else {
            nav = await Navigator.pushNamed(context, '/foot',
                arguments: ScreenArguments(code: barcode.code));
          }

          if (nav == null) {
            alreadyPassed = false;
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    passResult(formType);

    return Container(
        alignment: Alignment.center,
        height: MediaQuery.of(this.context).size.height * 0.9,
        child: buildQrView(context));
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
          controller.pauseCamera();
          this.barcode = barcode;
        });
      });
    });
  }
}
