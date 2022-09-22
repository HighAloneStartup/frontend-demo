import 'package:flutter/material.dart';
import 'LoginPage.dart';
// import './PostListPage.dart';
// import './PostWritePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(), //PostListPage(), //LoginPage(),
    );
  }
}
