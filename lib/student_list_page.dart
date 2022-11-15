import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/class.dart';
import 'models/user.dart';
import 'models/main_user.dart';
import 'styles/main_title_text.dart';
import 'styles/sub_title_text.dart';
import 'styles/list_block.dart';

class StudentListPage extends StatelessWidget {
  final MainUser user;
  const StudentListPage({Key? key, required this.user}) : super(key: key);

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
                  user: user,
                  gradeYear: gradeYear,
                  classGroup: classGroup,
                )),
      );
    }

    return Expanded(
      child: _ClassList(
        user: user,
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
  final MainUser user;
  _ClassList({
    Key? key,
    required this.user,
    required this.onChooseClass,
  }) : super(key: key);

  final Function onChooseClass;

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
                TextButton(
                  child: SubTitle(
                    title: "1학년 10반",
                    size: 15,
                    theme: Colors.white,
                  ),
                  onPressed: () => onChooseClass(1, 10),
                )
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
                TextButton(
                  child: SubTitle(
                    title: "2학년 10반",
                    size: 15,
                    theme: Colors.white,
                  ),
                  onPressed: () => onChooseClass(2, 10),
                )
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
                TextButton(
                  child: SubTitle(
                    title: "3학년 10반",
                    size: 15,
                    theme: Colors.white,
                  ),
                  onPressed: () => onChooseClass(3, 10),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StudentList extends StatelessWidget {
  final MainUser user;
  final int gradeYear;
  final int classGroup;

  const _StudentList(
      {Key? key,
      required this.user,
      required this.gradeYear,
      required this.classGroup})
      : super(key: key);

  Future<List<User>> _getStudentList() async {
    http.Response response = await http.get(
      Uri(
        scheme: 'http',
        host: 'ec2-44-242-141-79.us-west-2.compute.amazonaws.com',
        port: 9090,
        path: 'api/members/',
        queryParameters: {
          'gradeYear': '$gradeYear',
          'classGroup': '$classGroup',
        },
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${user.token}',
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
      future: _getStudentList(),
      builder: (context, AsyncSnapshot<List<User>> snapshot) {
        if (snapshot.hasData == false) {
          return CircularProgressIndicator();
        }

        var classInfo = Class(
          gradeYear: gradeYear,
          classGroup: classGroup,
          member: snapshot.data as List<User>,
        );
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
