import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'loginPage.dart';
import 'post_list_page.dart';
import 'new_post_page.dart';
import 'student_list_page.dart';
=======
import 'LoginPage.dart';
// import './PostListPage.dart';
// import './PostWritePage.dart';
>>>>>>> loginAndRegisterWithServer

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
      home: StudentListPage(), // PostListPage(),  //LoginPage(),
=======
      home: LoginPage(), //PostListPage(), //LoginPage(),
>>>>>>> loginAndRegisterWithServer
    );
  }
}
