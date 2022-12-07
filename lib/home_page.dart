import 'package:flutter/material.dart';
import 'package:high_alone_startup/student_list_page.dart';
import 'package:high_alone_startup/styles/main_title_text.dart';
import 'models/main_user.dart';
import 'styles/sub_title_text.dart';
import 'time_table_page.dart';
import 'my_page.dart';
import 'board_list_page.dart';
import 'notice_board_page.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/post.dart';
import 'models/simple_post.dart';

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
      body: SafeArea(
        child: _widgetOptions.elementAt(screenIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        currentIndex: screenIndex,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedItemColor: const Color.fromARGB(255, 115, 151, 142),
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
  Widget _title() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        top: 10,
        bottom: 10,
      ),
      child: Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.all(10),
        // padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            MainTitle(
              title: "CAUHIGH",
              theme: Color(0xFF3D5D54),
            ),
            SubTitle(
              title: "00 고등학교",
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _makeSection(
    String title,
  ) {
    return [
      Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Container(
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color(0xFFE4F0ED),
            borderRadius: BorderRadius.circular(10),
          ),
          child: MainTitle(
            title: title,
            size: 25,
            theme: const Color(0xFF3D5D54),
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _title(),
                  Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      IconButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                StudentListPage(user: widget.user),
                          ),
                        ),
                        icon: const Icon(
                          Icons.send_sharp,
                          color: Color(0xff3D5D54),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ..._makeSection("NOTICE"),
            Notice(user: widget.user),
            ..._makeSection("TODAY'S LUNCH"),
            const Lunch(),
          ],
        ),
      ),
    );
  }
}

class Notice extends StatefulWidget {
  final MainUser user;

  const Notice({Key? key, required this.user}) : super(key: key);

  @override
  State<Notice> createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
  List<SimplePost> _postList = [];

  Future<List<SimplePost>> _getPostList() async {
    http.Response response = await http.get(
      Uri(
        scheme: 'http',
        host: 'ec2-44-242-141-79.us-west-2.compute.amazonaws.com',
        port: 9090,
        path: 'api/notices/',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': widget.user.token,
      },
    );

    var statusCode = response.statusCode;
    var responseBody = utf8.decode(response.bodyBytes);

    switch (statusCode) {
      case 200:
        var parsed = jsonDecode(responseBody) as List;
        return parsed.map((e) {
          e['userName'] = "";
          e['userPhotoUrl'] = "";
          e['anonymous'] = false;

          return SimplePost.fromJson(e);
        }).toList();
      default:
        throw Exception('$statusCode');
    }
  }

  void _postPost(Post newPost) async {
    var data = jsonEncode({
      'title': newPost.title,
      'description': newPost.description,
      'published': newPost.published,
      'anonymous': newPost.anonymous,
    });
    http.Response response = await http.post(
        Uri(
          scheme: 'http',
          host: 'ec2-44-242-141-79.us-west-2.compute.amazonaws.com',
          port: 9090,
          path: 'api/notices/',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': widget.user.token,
        },
        body: data);

    var statusCode = response.statusCode;

    switch (statusCode) {
      case 200:
        break;
      case 201:
        break;
      default:
        throw Exception('$statusCode');
    }
  }

  Widget _body(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: Alignment.topCenter, //.center,
        children: [
          FutureBuilder(
            future: _getPostList(),
            builder: ((context, snapshot) {
              //print(snapshot.error);
              if (!snapshot.hasData) {
                return const SizedBox(
                  width: double.infinity,
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Color(0xFF3D5D54),
                  )),
                );
              }
              _postList = snapshot.data as List<SimplePost>;
              return TextButton(
                child: NoticeList(_postList, user: widget.user),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoticePage(user: widget.user),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }
}

class NoticeList extends StatelessWidget {
  final MainUser user;

  /// 테스트용 데이터
  final List<SimplePost> postList;

  const NoticeList(this.postList, {Key? key, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    postList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Container(
        height: 200,
        child: ListView.separated(
          itemCount: postList.length,
          itemBuilder: (BuildContext context, int index) {
            return _PostWidget(
              postList[index],
              user: user,
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              thickness: 1,
              height: 1,
              color: Color(0xFFE4F0ED),
            );
          },
        ),
      ),
    );
  }
}

class _PostWidget extends StatelessWidget {
  final MainUser user;
  final SimplePost post;

  const _PostWidget(this.post, {Key? key, required this.user})
      : super(key: key);

  String makeCreatedTime(DateTime time) {
    bool isToday = (time.year == DateTime.now().year) &&
        (time.month == DateTime.now().month) &&
        (time.day == DateTime.now().day);
    return isToday
        ? "${time.hour}:${time.minute}"
        : "${time.month}/${time.day}";
  }

  @override
  Widget build(BuildContext context) {
    var activate = Container(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SubTitle(
            title: makeCreatedTime(post.createdAt),
            theme: Colors.grey,
          ),
        ],
      ),
    );

    return Container(
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainTitle(
            title: post.anonymous ? "익명" : post.userName,
            size: 16,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 3),
            child: SubTitle(
              title: post.title,
              size: 16,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 3),
            child: SubTitle(
              title: post.description,
              size: 15,
              theme: const Color.fromARGB(255, 128, 128, 128),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          activate,
        ],
      ),
    );
  }
}

class Lunch extends StatefulWidget {
  const Lunch({super.key});

  @override
  State<Lunch> createState() => _LunchState();
}

class _LunchState extends State<Lunch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
    );
  }
}
