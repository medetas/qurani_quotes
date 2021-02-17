import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List> fetchUrdu() async {
  final response =
      await http.get('https://quranicquotes.com/wp-json/wp/v2/urdu');
  List data = jsonDecode(utf8.decode(response.bodyBytes));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return data;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load urdu');
  }
}
