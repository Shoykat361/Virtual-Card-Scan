import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:virtual_card/pages/form_page.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List'),
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context,FormPage.routeName);

        },
        shape: CircleBorder(),
        backgroundColor: Colors.red,
        foregroundColor: Colors.blueAccent,
        child: Icon(Icons.add),

      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        shape: CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        notchMargin: 10,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          backgroundColor: Colors.blueAccent,
          onTap: (index) {
            setState(() {
              selectedIndex =index;
            });

          },
          items:   [BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: 'All',
            backgroundColor: Colors.red,
          ),BottomNavigationBarItem(
            icon: const Icon(Icons.favorite),
            label: 'Favourite',
          ),
            ],
        ),
      ),
      body:  const Center(child: Text('Home'),),
    );
  }
}
