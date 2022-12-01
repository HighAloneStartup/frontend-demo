// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, deprecated_member_use
// import 'dart:async';
// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:high_alone_startup/home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'models/main_user.dart';
import './registerPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // const LoginPage({Key? key}) : super(key: key);
  String userIdValue = "";
  String userPwdValue = "";
  var responseValue;
  var loginID;

  static final storage =
      FlutterSecureStorage(); // 토큰 값과 로그인 유지 정보를 저장, SecureStorage 사용

  Future<MainUser> _loginRequest(userIdValue, userPwdValue) async {
    //String url = 'http://ec2-44-242-141-79.us-west-2.compute.amazonaws.com:9090/api/auth/signin';

    var data = jsonEncode({"email": userIdValue, "password": userPwdValue});

    http.Response response = await http.post(
      Uri(
        scheme: 'http',
        host: 'ec2-44-242-141-79.us-west-2.compute.amazonaws.com',
        port: 9090,
        path: 'api/auth/signin',
      ),
      headers: {
        'Content-Type': 'application/json',
      },
      body: data,
    );

    if (response.statusCode == 200) {
      responseValue = jsonDecode(utf8.decode(response.bodyBytes));
      // String token = responseValue["accessToken"];
      // Map<String, dynamic> id = responseValue["id"];

      return MainUser.fromJson(responseValue);
    } else if (response.statusCode == 404) {
      throw Exception('LOGIN FAIL');
    } else {
      throw Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          margin: EdgeInsets.only(
            left: 30,
            right: 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 30,
                margin: EdgeInsets.only(
                  left: 10,
                  bottom: 5,
                ),
                alignment: Alignment(-1.0, 0.0),
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                    color: const Color(0xff3D5D54),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: 15,
                margin: EdgeInsets.only(left: 10),
                alignment: Alignment(-1.0, 0.0),
                child: Text(
                  '로그인',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                height: 50,
                // width: 335,
                margin: EdgeInsets.only(
                  left: 10,
                  right: 10,
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
                    labelStyle: TextStyle(
                      fontSize: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: const Color(0xff3D5D54),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 50,
                // width: 300,
                margin: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
                child: TextField(
                  onChanged: (text) {
                    setState(() {
                      userPwdValue = text;
                    });
                  },
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      fontSize: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: const Color(0xff3D5D54),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: double.infinity,
                margin: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 5,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff3D5D54),
                    // textColor: Colors.white,
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                  // name instead of the actual result! : without parentheses
                  onPressed: () async {
                    MainUser user =
                        await _loginRequest(userIdValue, userPwdValue);
                    print(user.token);
                    print(user);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(user: user)));
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    child: Text(
                      '회원가입',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.lightBlue,
                      ),
                    ),
                    // name instead of the actual result! : without parentheses
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                  ),
                  TextButton(
                    child: Text(
                      '비밀번호 찾기',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.lightBlue,
                      ),
                    ),
                    // name instead of the actual result! : without parentheses
                    onPressed: () => {print('Clicked FIND PASSWORD')},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
