// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, deprecated_member_use
// import 'dart:async';
// import 'dart:convert';

// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String userIdValue = "";
  String userEmailValue = "";
  String userPwdValue = "";

  void _registerRequest(userIdValue, userEmailValue, userPwdValue) async {
    // String url = 'http://ec2-44-242-141-79.us-west-2.compute.amazonaws.com:9090/api/auth/signup';

    var data = jsonEncode({
      "name": userIdValue,
      "email": userEmailValue,
      "password": userPwdValue
    });

    http.Response response = await http.post(
      Uri(
        scheme: 'http',
        host: 'ec2-44-242-141-79.us-west-2.compute.amazonaws.com',
        port: 9090,
        path: 'api/auth/signup',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: data,
    );

    if (response.statusCode == 200) {
      print("Register Success !");
    } else if (response.statusCode == 400) {
      print('Register FAIL');
      throw Exception('Register FAIL');
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
                  'REGISTER',
                  style: TextStyle(
                    color: Colors.black,
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
                  '회원가입',
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
                  decoration: InputDecoration(
                    labelText: 'ID / Nickname',
                    labelStyle: TextStyle(
                      fontSize: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.black,
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
                      userEmailValue = text;
                    });
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email address',
                    labelStyle: TextStyle(
                      fontSize: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
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
                    labelText: 'Create Password',
                    labelStyle: TextStyle(
                      fontSize: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.black,
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
                child: TextButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    // textColor: Colors.white,
                  ),
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  // name instead of the actual result! : without parentheses
                  onPressed: () => {
                    _registerRequest(userIdValue, userEmailValue, userPwdValue),
                    print('[Register Screen] Clicked Register Button')
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '계정이 이미 있으신가요?',
                    style: TextStyle(color: Colors.blueGrey),
                    textAlign: TextAlign.center,
                  ),
                  TextButton(
                    child: Text(
                      '로그인',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.lightBlue),
                    ),
                    // name instead of the actual result! : without parentheses
                    onPressed: () {
                      Navigator.pop(context);
                    },
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
