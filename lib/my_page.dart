import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String name = "seo jin";
  String email = "swiftie1230@naver.com";
  String password = "swiftie1230";
  /* roles 형태 */
  String roles = "";
  /* int 형태 이거 맞나 */
  int gradeYear = 0;
  int classGroup = 0;
  int attendanceNumber = 0;
  int generationNumber = 0;
  int studentNumber = 0;
  /* date 형태 ? string 형태 ? */
  int birthday = 0;
  String phoneNumber = "010-8891-2306";
  String photoUrl = "";

  @override
  Widget build(BuildContext context) {
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
            height: 50,
            // width: 335,
            margin: const EdgeInsets.only(
              left: 5,
              right: 5,
            ),
            child: TextField(
              onChanged: (text) {
                setState(() {
                  roles = text;
                });
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Roles',
                labelStyle: const TextStyle(
                  fontSize: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Color(0xff3D5D54),
                  ),
                ),
              ),
            ),
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
  }
}
