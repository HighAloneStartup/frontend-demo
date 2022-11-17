import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/class.dart';
import 'models/user.dart';
import 'styles/main_title_text.dart';
import 'styles/sub_title_text.dart';
import 'styles/list_block.dart';

class StudentListPage extends StatelessWidget {
  const StudentListPage({Key? key}) : super(key: key);

  Widget _title() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          MainTitle(
            title: "STUDENT LIST",
            theme: Colors.white,
          ),
          SubTitle(
            title: "학생부",
            theme: Colors.white,
          )
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    void _onChooseClass(int gradeYear, int classGroup) {
      print("${gradeYear}학년 ${classGroup}반 학생 목록페이지로 이동");
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => _StudentList(
                  gradeYear: gradeYear,
                  classGroup: classGroup,
                )),
      );
    }

    return Expanded(
      child: _ClassList(
        onChooseClass: _onChooseClass,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          _title(),
          _body(context),
        ],
      ),
    );
  }
}

class _ClassList extends StatelessWidget {
  _ClassList({
    Key? key,
    required Function this.onChooseClass,
  }) : super(key: key);

  final Function onChooseClass;
  final List<Class> _firstGrade = [
    Class(gradeYear: 1, classGroup: 1, member: [
      User(name: '정동원A', email: 'JDWA@gmail.com'),
      User(name: "정동원B", email: 'JDWB@gmail.com'),
      User(name: "정동원C", email: 'JDWC@gmail.com'),
    ]),
    Class(gradeYear: 1, classGroup: 2, member: [
      User(name: '정동원D', email: 'JDWD@gmail.com'),
      User(name: "정동원E", email: 'JDWE@gmail.com'),
      User(name: "정동원F", email: 'JDWF@gmail.com'),
    ]),
    Class(gradeYear: 1, classGroup: 3, member: [
      User(name: '정동원G', email: 'JDWG@gmail.com'),
      User(name: "정동원H", email: 'JDWH@gmail.com'),
      User(name: "정동원I", email: 'JDWI@gmail.com'),
    ]),
  ];
  final List<Class> _secondGrade = [
    Class(gradeYear: 2, classGroup: 1, member: [
      User(name: '황서진A', email: 'HSJA@gmail.com'),
      User(name: "황서진B", email: 'HSJB@gmail.com'),
      User(name: "황서진C", email: 'HSJC@gmail.com'),
    ]),
    Class(gradeYear: 2, classGroup: 2, member: [
      User(name: '황서진D', email: 'HSJD@gmail.com'),
      User(name: "황서진E", email: 'HSJE@gmail.com'),
      User(name: "황서진F", email: 'HSJF@gmail.com'),
    ]),
    Class(gradeYear: 2, classGroup: 3, member: [
      User(name: '황서진G', email: 'HSJG@gmail.com'),
      User(name: "황서진H", email: 'HSJH@gmail.com'),
      User(name: "황서진I", email: 'HSJI@gmail.com'),
    ]),
  ];
  final List<Class> _thirdGrade = [
    Class(gradeYear: 3, classGroup: 1, member: [
      User(name: '손승표A', email: 'SSPA@gmail.com'),
      User(name: "손승표B", email: 'SSPB@gmail.com'),
      User(name: "손승표C", email: 'SSPC@gmail.com'),
    ]),
    Class(gradeYear: 3, classGroup: 2, member: [
      User(name: '손승표D', email: 'SSPD@gmail.com'),
      User(name: "손승표E", email: 'SSPE@gmail.com'),
      User(name: "손승표F", email: 'SSPF@gmail.com'),
    ]),
    Class(gradeYear: 3, classGroup: 3, member: [
      User(name: '손승표G', email: 'SSPG@gmail.com'),
      User(name: "손승표H", email: 'SSPH@gmail.com'),
      User(name: "손승표I", email: 'SSPI@gmail.com'),
    ]),
  ];

  List<Widget> _makeButtons(int gradeYear, int classGroup) {
    List<Widget> result = [];
    for (int i = 1; i <= classGroup; i++) {
      result.add(TextButton(
        child: SubTitle(
          title: "$gradeYear학년 $i반",
          size: 15,
          theme: Colors.white,
        ),
        onPressed: () => onChooseClass(gradeYear, i),
      ));
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        children: <Widget>[
          const MainTitle(
            title: "FIRST GRADE",
            size: 25,
            theme: Colors.white,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                ..._makeButtons(1, 13),
              ],
            ),
          ),
          const MainTitle(
            title: "SECOND GRADE",
            size: 25,
            theme: Colors.white,
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                ..._makeButtons(2, 13),
              ],
            ),
          ),
          const MainTitle(
            title: "THIRD GRADE",
            size: 25,
            theme: Colors.white,
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                ..._makeButtons(3, 13),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StudentList extends StatelessWidget {
  final int gradeYear;
  final int classGroup;
  final String token =
      'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJqZHcxMDQyNzEwQGdtYWlsLmNvbSIsImlhdCI6MTY2NzQ2OTAxNywiZXhwIjoxNjY3NTU1NDE3fQ.6Q14qzK0947f3Wfhun4NTOv12GJgjdkt9NoAVP2LZOygxAT9xzeIu2h4iPEXmqZinQ9viV6SeTEH48Ulf9UCNA';

  const _StudentList(
      {Key? key, required this.gradeYear, required this.classGroup})
      : super(key: key);

  Future<List<User>> _getStudentList() async {
    String url =
        'http://ec2-44-242-141-79.us-west-2.compute.amazonaws.com:9090/api/members/?gradeYear=${gradeYear}&classGroup=${classGroup}';

    http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token}',
      },
    );

    var statusCode = response.statusCode;
    var responseBody = utf8.decode(response.bodyBytes);

    switch (statusCode) {
      case 200:
        var parsed = jsonDecode(responseBody) as List;
        print('결과 : ${parsed.runtimeType}');
        return parsed.map((e) => User.fromJson(e)).toList();
      default:
        throw Exception('$statusCode');
    }
  }

  Widget _title() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          MainTitle(
            title: "STUDENT LIST",
            theme: Colors.white,
          ),
          SubTitle(
            title: "학생부",
            theme: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return FutureBuilder(
      future: _getStudentList(), //future작업을 진행할 함수
      //snapshot은 getWeather()에서 return해주는 타입에 맞추어 사용한다.
      builder: (context, AsyncSnapshot<List<User>> snapshot) {
        //데이터가 만약 들어오지 않았을때는 뱅글뱅글 로딩이 뜬다
        if (snapshot.hasData == false) {
          return CircularProgressIndicator();
        }

        var classInfo = Class(
          gradeYear: gradeYear,
          classGroup: classGroup,
          member: snapshot.data as List<User>,
        );
        //데이터가 제대로 불러와진 경우 현재온도, 최저,최고 온도와 코드에 따른 아이콘을 표시하는 부분
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainTitle(
                  title: "${classInfo.gradeYear} - ${classInfo.classGroup}",
                  size: 25.0,
                  theme: Colors.white,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      ...classInfo.member.map((member) {
                        return TextButton(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: ListBlock(
                              start: Container(
                                width: 60,
                                margin: const EdgeInsets.only(right: 10),
                                height: 60,
                                child: Image.asset('assets/images/default.jpg'),
                              ),
                              center: SubTitle(
                                title: member.name,
                                size: 15,
                                theme: Colors.white,
                              ),
                              end: const Icon(Icons.message,
                                  color: Colors.white),
                            ),
                          ),
                          onPressed: () => print(member.name),
                        );
                      })
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            _title(),
            _body(),
          ],
        ),
      ),
    );
  }
}
