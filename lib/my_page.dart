import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:high_alone_startup/models/authority.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'models/user.dart';
import 'models/main_user.dart';

class MyPage extends StatefulWidget {
  final MainUser user;
  const MyPage({super.key, required this.user});

  @override
  State<MyPage> createState() => _MyPageState(user: user);
}

class _MyPageState extends State<MyPage> {
  _MyPageState({required this.user});

  final MainUser user;

  String name = "seo jin";
  String email = "swiftie1230@naver.com";
  String password = "swiftie1230";
  /* roles 형태 */
  List<Authority> roles = [];
  /* int 형태 이거 맞나 */
  int gradeYear = 0;
  int classGroup = 0;
  int attendanceNumber = 0;
  int generationNumber = 0;
  int studentNumber = 0;
  /* date 형태 ? string 형태 ? */
  String birthday = "";
  String phoneNumber = "010-8891-2306";
  String photoUrl = "";

  Future<User> _getUserData() async {
    http.Response response = await http.get(
      Uri(
        scheme: 'http',
        host: 'ec2-44-242-141-79.us-west-2.compute.amazonaws.com',
        port: 9090,
        path: 'api/members/mine',
        /*
        queryParameters: {
          'gradeYear': '$gradeYear',
          'classGroup': '$classGroup',
        },
        */
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': user.token,
      },
    );

    var statusCode = response.statusCode;
    var responseBody = utf8.decode(response.bodyBytes);

    switch (statusCode) {
      case 200:
        var parsed = jsonDecode(responseBody) as Map<String, dynamic>;
        print('결과 : ${parsed}');
        print('결과타입 : ${parsed.runtimeType}');
        return User.fromJson(parsed);
      default:
        throw Exception('$statusCode');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUserData(),
      builder: ((context, snapshot) {
        print("에러 : ${snapshot.error}");
        print("받은 데이터 : ${snapshot.data}");
        if (!snapshot.hasData) {
          //print(snapshot.error);
          return const Center(child: CircularProgressIndicator());
        }

        User currentUser = snapshot.data as User;

        name = currentUser.name;
        email = currentUser.email;
        /* roles 형태 */
        roles = currentUser.authorities != null ? currentUser.authorities! : [];
        /* int 형태 이거 맞나 */
        gradeYear = currentUser.gradeYear != null ? currentUser.gradeYear! : 0;
        classGroup =
            currentUser.classGroup != null ? currentUser.classGroup! : 0;
        attendanceNumber = currentUser.attendanceNumber != null
            ? currentUser.attendanceNumber!
            : 0;
        generationNumber = currentUser.generationNumber != null
            ? currentUser.generationNumber!
            : 0;
        studentNumber =
            currentUser.studentNumber != null ? currentUser.studentNumber! : 0;
        /* date 형태 ? string 형태 ? */
        birthday = currentUser.birthday != null ? currentUser.birthday! : "";
        phoneNumber =
            currentUser.phoneNumber != null ? currentUser.phoneNumber! : "";
        photoUrl = currentUser.photoUrl != null ? currentUser.photoUrl! : "";

        return Padding(
          padding: const EdgeInsets.only(right: 30.0, left: 30.0),
          child: ListView(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              // Image.file(userImage),
              Image.asset(
                'assets/images/default.jpg',
                width: 200,
                height: 200,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xff3D5D54),
                      // textColor: Colors.white,
                    ),
                    child: const Text(
                      "이미지 선택",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "이미지 삭제",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50.0,
              ),
              Container(
                height: 15,
                margin: const EdgeInsets.only(left: 10),
                alignment: const Alignment(-1.0, 0.0),
                child: const Text(
                  'NICKNAME',
                  style: TextStyle(
                    color: Color(0xff3D5D54),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 5,
                ),
                child: Text(name),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                height: 15,
                margin: const EdgeInsets.only(left: 10),
                alignment: const Alignment(-1.0, 0.0),
                child: const Text(
                  'EMAIL',
                  style: TextStyle(
                    color: Color(0xff3D5D54),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 5,
                ),
                child: Text(email),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                height: 15,
                margin: const EdgeInsets.only(left: 10),
                alignment: const Alignment(-1.0, 0.0),
                child: const Text(
                  'PASSWORD',
                  style: TextStyle(
                    color: Color(0xff3D5D54),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 5,
                ),
                child: Text(password),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                height: 15,
                margin: const EdgeInsets.only(left: 10),
                alignment: const Alignment(-1.0, 0.0),
                child: const Text(
                  'ROLES',
                  style: TextStyle(
                    color: Color(0xff3D5D54),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 5,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: roles.map((role) => Text(role.name)).toList()),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                height: 15,
                margin: const EdgeInsets.only(left: 10),
                alignment: const Alignment(-1.0, 0.0),
                child: const Text(
                  'GRADE',
                  style: TextStyle(
                    color: Color(0xff3D5D54),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 5,
                ),
                child: Text("$gradeYear"),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                height: 15,
                margin: const EdgeInsets.only(left: 10),
                alignment: const Alignment(-1.0, 0.0),
                child: const Text(
                  'CLASS',
                  style: TextStyle(
                    color: Color(0xff3D5D54),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 5,
                ),
                child: Text("$classGroup"),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                height: 15,
                margin: const EdgeInsets.only(left: 10),
                alignment: const Alignment(-1.0, 0.0),
                child: const Text(
                  'ATTENDANCE NUMBER',
                  style: TextStyle(
                    color: Color(0xff3D5D54),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 5,
                ),
                child: Text("$attendanceNumber"),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                height: 15,
                margin: const EdgeInsets.only(left: 10),
                alignment: const Alignment(-1.0, 0.0),
                child: const Text(
                  'GENERATION NUMBER',
                  style: TextStyle(
                    color: Color(0xff3D5D54),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 5,
                ),
                child: Text("$generationNumber"),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                height: 15,
                margin: const EdgeInsets.only(left: 10),
                alignment: const Alignment(-1.0, 0.0),
                child: const Text(
                  'STUDENT NUMBER',
                  style: TextStyle(
                    color: Color(0xff3D5D54),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 5,
                ),
                child: Text("$studentNumber"),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                height: 15,
                margin: const EdgeInsets.only(left: 10),
                alignment: const Alignment(-1.0, 0.0),
                child: const Text(
                  'BIRTHDAY',
                  style: TextStyle(
                    color: Color(0xff3D5D54),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 5,
                ),
                child: Text("$birthday"),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                height: 15,
                margin: const EdgeInsets.only(left: 10),
                alignment: const Alignment(-1.0, 0.0),
                child: const Text(
                  'PHONE NUMBER',
                  style: TextStyle(
                    color: Color(0xff3D5D54),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 5,
                ),
                child: Text(phoneNumber),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                height: 50,
                width: double.infinity,
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 5,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff3D5D54),
                    // textColor: Colors.white,
                  ),
                  child: const Text(
                    '저장하기',
                    style: TextStyle(color: Colors.white),
                  ),
                  // name instead of the actual result! : without parentheses
                  onPressed: () {},
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
