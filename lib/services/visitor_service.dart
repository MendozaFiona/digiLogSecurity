import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../json_models/add_visitor.dart';
import 'config.dart';

Future<AddVisitor> addVisitor(var data) async {
  var response = await http.post(Uri.parse('$API_URL/addvisitor'),
      body: data); // change the uri

  if (response.statusCode == 201 || response.statusCode == 422) {
    return AddVisitor.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('An error occured when trying to register');
  }
}
