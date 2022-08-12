// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';

class registerPage extends StatelessWidget {
  const registerPage({Key? key}) : super(key: key);

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
                child: RaisedButton(
                  color: Colors.black,
                  textColor: Colors.white,
                  child: Text('Register'),
                  // name instead of the actual result! : without parentheses
                  onPressed: () =>
                      {print('[Register Screen] Clicked Register Button')},
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
                  FlatButton(
                    textColor: Colors.lightBlue,
                    child: Text(
                      '로그인',
                      textAlign: TextAlign.center,
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
