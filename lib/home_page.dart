import 'package:flutter/material.dart';
import 'package:high_alone_startup/student_list_page.dart';
import 'models/main_user.dart';

class HomePage extends StatelessWidget {
  final MainUser user;
  const HomePage({Key? key, required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("학생부"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StudentListPage(user: user)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
