import 'package:flutter/material.dart';
import 'Account.dart';
import 'Home_page.dart';

class BottomButton extends StatefulWidget {
  const BottomButton({super.key});

  @override
  State<BottomButton> createState() => _BottomButtonState();
}

class _BottomButtonState extends State<BottomButton> {
  int _selectedIndex = 0;

  final _screens = [
    Homepage(),
    const Scaffold(body: Center(child: Text('Shorts'))),
    const Scaffold(body: Center(child: Text('Add'))),
    const Scaffold(body: Center(child: Text('Subscriptions'))),
    AccountPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: _screens
            .asMap()
            .map((i, screen) => MapEntry(
                i,
                Offstage(
                  offstage: _selectedIndex != i,
                  child: screen,
                )))
            .values
            .toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        selectedFontSize: 10.0,
        unselectedFontSize: 10.0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
            label: 'Shorts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle,size: 45,color: Colors.white),
            activeIcon: Icon(Icons.add_circle),
            label: '',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.subscriptions_outlined),
            activeIcon: Icon(Icons.subscriptions),
            label: 'Subscriptions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            activeIcon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black,
      ),
    );
  }
}