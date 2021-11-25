import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../json_models/add_visitor.dart';
import 'config.dart';

Future<AddVisitor> addUser(var data) async {
  var response = await http.post(Uri.parse('$API_URL/register'), body: data);

  if (response.statusCode == 201 || response.statusCode == 422) {
    return AddVisitor.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('An error occured when trying to register');
  }
}
