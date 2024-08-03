// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomemo/bloc/user/user_bloc.dart';
import 'package:gomemo/bloc/user/user_event.dart';
import 'package:gomemo/bloc/user/user_state.dart';
import 'package:gomemo/views/home/home.view.dart';
import 'package:gomemo/views/profile/profile.view.dart';
import 'package:iconsax/iconsax.dart';

class Base extends StatefulWidget {
  const Base({super.key});

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    HomeView(),
    ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(FetchCurrentUser());
  }

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
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            return _widgetOptions[_selectedIndex];
          } else if (state is UserError) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return Center(child: Text('Initializing...'));
        },
      ),
    );
  }
}
