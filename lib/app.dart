import 'package:flutter/material.dart';
import 'main.dart';
import 'login.dart';
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoogleSignIn',
      debugShowCheckedModeBanner: false,
      routes: {
      '/': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),

      },
    );
  }
}