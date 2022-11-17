import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'new_post_page.dart';
import 'styles/main_title_text.dart';
import 'styles/sub_title_text.dart';
import 'post_list.dart';
import 'models/post.dart';
import 'models/user.dart';
import 'models/main_user.dart';

class PostListPage extends StatefulWidget {
  final MainUser user;

  const PostListPage({Key? key, required this.user}) : super(key: key);

  @override
  State<PostListPage> createState() => _PostListPageState(user: user);
}

class _PostListPageState extends State<PostListPage> {
  final MainUser user;
  List<Post> _postList = [];

  _PostListPageState({required this.user});

  void _transition(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => NewPostPage(
                _addNewPost,
                user: user,
              )),
    );
  }

  void _addNewPost(Post newPost) async {
    _postPost(newPost);
    await _getPostList(null);
    setState(() {
      _postList.add(newPost);
    });
  }

  Future<List<Post>> _getPostList(String? id) async {
    id ??= "";
    http.Response response = await http.get(
      Uri(
        scheme: 'http',
        host: 'ec2-44-242-141-79.us-west-2.compute.amazonaws.com',
        port: 9090,
        path: 'api/boards/$id',
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
        var parsed = jsonDecode(responseBody) as List;
        //print('결과 : ${parsed}');
        return parsed.map((e) => Post.fromJson(e)).toList();
      default:
        throw Exception('$statusCode');
    }
  }

  void _postPost(Post newPost) async {
    var data = jsonEncode({
      'title': newPost.title,
      'description': newPost.description,
      'published': newPost.published,
    });
    http.Response response = await http.post(
        Uri(
          scheme: 'http',
          host: 'ec2-44-242-141-79.us-west-2.compute.amazonaws.com',
          port: 9090,
          path: 'api/boards/',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': user.token,
        },
        body: data);

    var statusCode = response.statusCode;
    var responseBody = utf8.decode(response.bodyBytes);

    switch (statusCode) {
      case 200:
        break;
      case 201:
        break;
      default:
        throw Exception('$statusCode');
    }
  }

  Widget _title() {
    return Container(
      padding: const EdgeInsets.only(top: 35, bottom: 35),
      child: Column(
        children: const [
          MainTitle(
            title: "FREE BOARD",
            theme: Colors.white,
          ),
          SubTitle(
            title: "자유게시판",
            theme: Colors.white,
          )
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Expanded(
      //height: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          FutureBuilder(
            future: _getPostList(null),
            builder: ((context, snapshot) {
              if (!snapshot.hasData) {
                //print(snapshot.error);
                return const SizedBox(
                  width: double.infinity,
                  child: CircularProgressIndicator(),
                );
              }
              _postList = snapshot.data as List<Post>;
              return PostList(_postList, user: user);
            }),
          ),
          Positioned(
            bottom: 40,
            child: _TransitionButton(() => _transition(context)),
          ),
        ],
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

class _TransitionButton extends StatelessWidget {
  final VoidCallback _callback;

  const _TransitionButton(this._callback, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(148, 34),
        primary: Colors.black,
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
