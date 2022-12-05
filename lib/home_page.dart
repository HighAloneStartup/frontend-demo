import 'package:flutter/material.dart';
import 'package:high_alone_startup/loginPage.dart';
import 'package:high_alone_startup/registerPage.dart';
import 'package:high_alone_startup/student_list_page.dart';
import 'models/main_user.dart';
import 'time_table_page.dart';
import 'my_page.dart';
import 'board_list_page.dart';

import 'DMPage.dart';

class HomePage extends StatefulWidget {
  final MainUser user;
  HomePage({Key? key, required this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState(user: user);
}

class _HomePageState extends State<HomePage> {
  final MainUser user;
  int screenIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  _HomePageState({required this.user});
  void _onItemTapped(int index) {
    setState(() {
      screenIndex = index;
    });
  }

  // 메인 위젯
  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      MainPage(
        user: user,
      ),
      const TimeTablePage(),
      BoardListPage(user: user),
      MyPage(user: user),
    ];
    return Scaffold(
      body: _widgetOptions.elementAt(screenIndex),
      /*
      SafeArea(
        child: _widgetOptions.elementAt(screenIndex),
      ),
      */
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        currentIndex: screenIndex,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedItemColor: Color.fromARGB(255, 115, 151, 142),
        selectedItemColor: const Color(0xff3D5D54),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Color(0xff3D5D54),
              ),
              label: 'HOME'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.punch_clock_outlined,
                color: Color(0xff3D5D54),
              ),
              label: 'TIME TABLE'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
                color: Color(0xff3D5D54),
              ),
              label: 'BOARDS'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.people,
                color: Color(0xff3D5D54),
              ),
              label: 'MY PAGE')
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  final MainUser user;
  MainPage({Key? key, required this.user}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextButton(
              child: Text("DM"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DMPage(user: widget.user),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
