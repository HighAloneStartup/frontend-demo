import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main_user.dart';

class DB {
  static void errorCode(int code, BuildContext context) {
    String result = "";
    switch (code) {
      case 200:
        result = "$code : 성공";
        break;
      case 201:
        result = "$code : 생성됨";
        break;
      case 204:
        result = "$code : 비어있음";
        break;
      case 401:
        result = "$code : 권한없음";
        break;
      case 404:
        result = "$code : Not Found";
        break;
      case 500:
        result = "$code : 서버에 문제가 생겼습니다.";
        break;
      default:
        result = "error code: $code";
        break;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(result),
          actions: <Widget>[
            TextButton(
              child: const Text("닫기"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  static void putLike({
    required String postId,
    required String boardUrl,
    required MainUser user,
    required BuildContext context,
  }) async {
    http.Response response = await http.put(
      Uri(
        scheme: 'http',
        host: 'ec2-44-242-141-79.us-west-2.compute.amazonaws.com',
        port: 9090,
        path: 'api/$boardUrl/$postId/like',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': user.token,
      },
    );

    var statusCode = response.statusCode;

    switch (statusCode) {
      case 200:
        break;
      default:
        DB.errorCode(statusCode, context);
        throw Exception('$statusCode');
    }
  }

  static void putComment({
    required String postId,
    required String boardUrl,
    required String description,
    required MainUser user,
    required BuildContext context,
  }) async {
    var data = jsonEncode({'description': description});
    http.Response response = await http.put(
      Uri(
        scheme: 'http',
        host: 'ec2-44-242-141-79.us-west-2.compute.amazonaws.com',
        port: 9090,
        path: 'api/$boardUrl/$postId/comment',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': user.token,
      },
      body: data,
    );

    var statusCode = response.statusCode;

    switch (statusCode) {
      case 200:
        break;
      default:
        DB.errorCode(statusCode, context);
        throw Exception('$statusCode');
    }
  }
}
