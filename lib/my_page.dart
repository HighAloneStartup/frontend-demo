import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String userNickname = "";
  String userIdValue = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30.0, left: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                  primary: Colors.black,
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
              '닉네임',
              style: TextStyle(
                color: Colors.black,
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
            child: TextField(
              onChanged: (text) {
                setState(() {
                  userNickname = text;
                });
              },
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'NickName',
                labelStyle: const TextStyle(
                  fontSize: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.black,
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
              '이메일',
              style: TextStyle(
                color: Colors.black,
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
            child: TextField(
              onChanged: (text) {
                setState(() {
                  userIdValue = text;
                });
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email Address',
                labelStyle: const TextStyle(
                  fontSize: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
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
                primary: Colors.black,
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
