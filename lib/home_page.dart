import 'package:flutter/material.dart';
import 'package:high_alone_startup/loginPage.dart';
import 'package:high_alone_startup/registerPage.dart';
import 'package:high_alone_startup/student_list_page.dart';
import 'models/main_user.dart';
import 'time_table_page.dart';
import 'my_page.dart';
import 'board_list_page.dart';

class HomePage extends StatefulWidget {
  final MainUser user;
  HomePage({Key? key, required this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final MainUser user;
  int screenIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final List<Widget> _widgetOptions = <Widget>[
    LoginPage(),
    TimeTablePage(),
    RegisterPage(),
    MyPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      screenIndex = index;
    });
  }

  // 메인 위젯
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _widgetOptions.elementAt(screenIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.black,
        currentIndex: screenIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.blue,
              ),
              label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.punch_clock_outlined,
                color: Colors.blue,
              ),
              label: 'timeTable'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
                color: Colors.blue,
              ),
              label: 'list'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.people,
                color: Colors.blue,
              ),
              label: 'my')
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}

  /*

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.black,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextButton(
                child: Text("학생부"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudentListPage(user: widget.user),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          // backgroundColor: Colors.black,
          currentIndex: screenIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.blue,
                ),
                label: 'home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.punch_clock_outlined,
                  color: Colors.blue,
                ),
                label: 'timeTable'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                  color: Colors.blue,
                ),
                label: 'list'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.people,
                  color: Colors.blue,
                ),
                label: 'my')
          ],
          onTap: (value) {
            setState(() {
              //상태 갱신이 되지 않으면 동작을 하지 않음
              screenIndex = value;
            });
          },
        ));
  }
}
*/