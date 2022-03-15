import 'package:flutter/material.dart';
import 'package:qr_reader/screens/screens.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      routes: {
        'home':(_)=> HomeScreen(),
        'maps':(_)=> MapScreen(),
      },
    );
  }
}