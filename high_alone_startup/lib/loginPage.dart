// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
                height: 28,
                margin: EdgeInsets.only(
                  left: 10,
                  bottom: 5,
                ),
                alignment: Alignment(-1.0, 0.0),
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
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
                height: 20.0,
              ),
              Container(
                height: 50,
                // width: 335,
                margin: EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Email Address',
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
                  decoration: InputDecoration(
                    labelText: 'Password',
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
                child: RaisedButton(
                  color: Colors.black,
                  textColor: Colors.white,
                  child: Text('Login'),
                  // name instead of the actual result! : without parentheses
                  onPressed: () => {print('Clicked')},
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    textColor: Colors.lightBlue,
                    child: Text(
                      '회원가입',
                      textAlign: TextAlign.center,
                    ),
                    // name instead of the actual result! : without parentheses
                    onPressed: () => {print('Clicked REGISTER')},
                  ),
                  FlatButton(
                    textColor: Colors.lightBlue,
                    child: Text(
                      '비밀번호 찾기',
                      textAlign: TextAlign.center,
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
