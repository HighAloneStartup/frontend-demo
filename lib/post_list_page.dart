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
  final String boardName;

  const PostListPage({Key? key, required this.user, required this.boardName})
      : super(key: key);

  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  List<Post> _postList = [];

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
        'Authorization': widget.user.token,
      },
    );

    var statusCode = response.statusCode;
    var responseBody = utf8.decode(response.bodyBytes);

    switch (statusCode) {
      case 200:
        var parsed = jsonDecode(responseBody) as List;
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
          'Authorization': widget.user.token,
        },
        body: data);

    var statusCode = response.statusCode;

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
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MainTitle(
            title: "FREE BOARD",
            theme: Color(0xFF3D5D54),
          ),
          SubTitle(
            title: widget.boardName,
          )
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
            future: _getPostList(null),
            builder: ((context, snapshot) {
              //print(snapshot.error);
              if (!snapshot.hasData) {
                return const SizedBox(
                  width: double.infinity,
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Color(0xFF3D5D54),
                  )),
                );
              }
              _postList = snapshot.data as List<Post>;
              return PostList(_postList, user: widget.user);
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
