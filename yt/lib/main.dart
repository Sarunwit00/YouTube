import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yt/screens/Bottom_button.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouTube UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        bottomNavigationBarTheme: 
        const BottomNavigationBarThemeData(selectedItemColor: Colors.white),
      ),
      home:BottomButton(),
    );
  }
}