import 'package:flutter/material.dart';

class PassArgumentsScreen extends StatelessWidget {
  static const routeName = '/passArguments'; //delete later?

  final String name;
  final String code;

  const PassArgumentsScreen({
    Key key,
    this.name,
    this.code,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ScreenArguments {
  //final String name;
  final String code;

  ScreenArguments(/*this.name, */ this.code);
}
