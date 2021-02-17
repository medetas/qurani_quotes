import 'package:flutter/material.dart';
import 'package:quraniquotes/screens/homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qurani quotes',
      home: HomePage(),
    );
  }
}
