import 'package:flutter/material.dart';
import 'package:quraniquotes/widgets/hindi.dart';
import 'package:quraniquotes/widgets/urdu.dart';
import 'package:quraniquotes/widgets/video.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    Urdu(),
    Hindi(),
    VideoPlayer(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qurani quotes'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.language),
            label: 'Urdu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.language),
            label: 'Hindi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Video',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
