import 'package:flutter/material.dart';
import 'package:high_alone_startup/models/main_user.dart';
import './styles/main_title_text.dart';
import './styles/sub_title_text.dart';
import './models/post.dart';
import './models/main_user.dart';

class PostPage extends StatelessWidget {
  final MainUser user;
  final Post post;

  const PostPage(this.post, {Key? key, required this.user}) : super(key: key);

  void _transition(BuildContext context) {
    Navigator.pop(context);
  }

  Widget _body(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          _PostHead(post: post),
          _PostBody(post: post),
          //button
          Container(
              margin: const EdgeInsets.all(40),
              child: _TransitionButton(() => _transition(context))),
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
          _body(context),
        ],
      ),
    );
  }
}

class _PostHead extends StatelessWidget {
  final Post post;

  const _PostHead({required this.post, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 70,
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: post.image == null
                ? Image.asset('images/default.jpg')
                : Image.asset(post.image as String),
          ),
          SubTitle(
            title: post.isAnonymous ? '익명' : post.user.name,
            theme: Colors.white,
          ),
        ],
      ),
    );
  }
}

class _PostBody extends StatelessWidget {
  final Post post;
  const _PostBody({required this.post, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainTitle(
              title: post.title,
              theme: Colors.white,
            ),
            SubTitle(
              title: post.content,
              theme: Colors.white,
            ),
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
        primary: Colors.black,
        side: const BorderSide(
          color: Colors.white,
          width: 0.5,
        ),
      ),
      onPressed: _callback,
      child: const Text("목록으로 돌아가기"),
    );
  }
}
