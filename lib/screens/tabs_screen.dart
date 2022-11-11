import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartphone_disease_diagnosis/screens/appointments_screen.dart';
import 'package:smartphone_disease_diagnosis/screens/doctors_screen.dart';
import 'package:smartphone_disease_diagnosis/screens/scan_home_screen.dart';

import 'home_screen.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/navigation_screen';
  final int? atIndex;
  const TabsScreen({Key? key, this.atIndex}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = [];

  @override
  void initState() {
    super.initState();

    if (widget.atIndex != null) {
      setState(() {
        _selectedIndex = widget.atIndex!;
      });
    }
    _widgetOptions = [
      const HomeScreen(),
      const ScanHomeScreen(),
      const DoctorsScreen(),
      const AppointmentsScreen(),
    ];
  }

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        // leading: const Icon(
        //   Icons.menu,
        //   color: Colors.black,
        // ),

        leading: PopupMenuButton<int>(
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          itemBuilder: (context) => [
            // PopupMenuItem 1
            PopupMenuItem(
              value: 1,
              // row with 2 children
              child: Row(
                children: const [
                  Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Log Out")
                ],
              ),
            ),
          ],
          offset: const Offset(0, 50),
          color: Colors.grey[100],
          elevation: 2,
          onSelected: (value) {
            if (value == 1) {
              FirebaseAuth.instance.signOut();
            }
          },
        ),
      ),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _selectPage,
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedIconTheme:
            const IconThemeData(color: Color.fromARGB(255, 127, 164, 248)),
        selectedItemColor: const Color.fromARGB(255, 127, 164, 248),
        unselectedItemColor: const Color.fromARGB(255, 194, 194, 194),
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: "Scan",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.healing_rounded),
            label: "Book",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: "Calendar",
          ),
        ],
        currentIndex: _selectedIndex,
      ),
      // drawer: Drawer(
      //   child: MainDrawer(),
      // ),
    );
  }
}
