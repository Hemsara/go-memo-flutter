// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gomemo/views/home/home.view.dart';
import 'package:iconsax/iconsax.dart';

class Base extends StatefulWidget {
  const Base({super.key});

  @override
  State<Base> createState() => _HomeState();
}

class _HomeState extends State<Base> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    HomeView(),
    HomeView(),
    HomeView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> cards = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Iconsax.home),
              label: 'Base',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.note),
              label: 'Notes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.user),
              label: 'Profile',
            ),
          ],
          selectedLabelStyle: TextStyle(fontSize: 20),
          unselectedLabelStyle: TextStyle(fontSize: 17),
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.white,
          selectedItemColor: Color(0xff7FFA88),
          onTap: _onItemTapped,
        ),
        body: _widgetOptions[_selectedIndex]);
  }
}
