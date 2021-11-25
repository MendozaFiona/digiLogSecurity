import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../json_models/get_visitor.dart';
import 'config.dart';

Future<EntryInfo> discoverEntry() async {
  var response =
      await http.get(Uri.parse('$API_URL/visit_entries')); // changeURI

  if (response.body.isNotEmpty) {
    if (response.statusCode == 200) {
      return EntryInfo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('An error occured when retrieving entries');
    }
  } else {
    return null;
  }
}
