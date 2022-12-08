import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'new_post_page.dart';
import 'styles/main_title_text.dart';
import 'styles/sub_title_text.dart';
import 'notice_list.dart';
import 'models/post.dart';
import 'models/simple_post.dart';
import 'models/main_user.dart';
import 'models/DB.dart';

class NoticePage extends StatefulWidget {
  final MainUser user;

  const NoticePage({Key? key, required this.user}) : super(key: key);

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  List<SimplePost> _postList = [];

  void _transition(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => NewPostPage(
                _addNewPost,
                user: widget.user,
              )),
    );
  }

  void _addNewPost(Post newPost) async {
    _postPost(newPost);
    await _getPostList();
    setState(() {
      _postList.add(SimplePost.fromPost(newPost));
    });
  }

  Future<List<SimplePost>> _getPostList() async {
    http.Response response = await http.get(
      Uri(
        scheme: 'http',
        host: 'ec2-44-242-141-79.us-west-2.compute.amazonaws.com',
        port: 9090,
        path: 'api/notices/',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': widget.user.token,
      },
    );

    var statusCode = response.statusCode;
    var responseBody = utf8.decode(response.bodyBytes);

    switch (statusCode) {
      case 200:
        var parsed = jsonDecode(responseBody) as List;
        return parsed.map((e) {
          e['userName'] = "";
          e['userPhotoUrl'] = "";
          e['anonymous'] = false;

          return SimplePost.fromJson(e);
        }).toList();
      default:
        DB.errorCode(statusCode, context);
        throw Exception('$statusCode');
    }
  }

  void _postPost(Post newPost) async {
    var data = jsonEncode({
      'title': newPost.title,
      'description': newPost.description,
      'published': newPost.published,
      'anonymous': newPost.anonymous,
    });
    http.Response response = await http.post(
        Uri(
          scheme: 'http',
          host: 'ec2-44-242-141-79.us-west-2.compute.amazonaws.com',
          port: 9090,
          path: 'api/notices/',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': widget.user.token,
        },
        body: data);

    var statusCode = response.statusCode;

    switch (statusCode) {
      case 200:
      case 201:
        break;
      default:
        DB.errorCode(statusCode, context);
        throw Exception('$statusCode');
    }
  }

  Widget _title() {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
              color: Color(0xFF3D5D54),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              MainTitle(
                title: "NOTICE",
                theme: Color(0xFF3D5D54),
              ),
              SubTitle(
                title: "공지사항",
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: Alignment.center,
        children: [
          FutureBuilder(
            future: _getPostList(),
            builder: ((context, snapshot) {
              //print(snapshot.error);
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  width: double.infinity,
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Color(0xFF3D5D54),
                  )),
                );
              }
              if (snapshot.data == null) {
                return const SubTitle(title: "데이터를 불러오는데 실패하였습니다.");
              }
              _postList = snapshot.data as List<SimplePost>;
              return NoticeList(_postList, user: widget.user);
            }),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _title(),
            _body(context),
          ],
        ),
      ),
    );
  }
}

class _TransitionButton extends StatelessWidget {
  final VoidCallback _callback;

  const _TransitionButton(this._callback, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(148, 34),
        backgroundColor: const Color(0xFF3D5D54),
        side: const BorderSide(
          color: Colors.white,
          width: 0.5,
        ),
      ),
      onPressed: _callback,
      child: const Text("글쓰기"),
    );
  }
}
