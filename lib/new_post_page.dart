import 'package:flutter/material.dart';
import 'styles/main_title_text.dart';
import 'styles/sub_title_text.dart';
import './models/post.dart';
import './models/user.dart';

class NewPostPage extends StatelessWidget {
  final User user;
  final Function addPost;
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  bool _isAnonymous = true;

  NewPostPage(this.addPost, {required this.user, Key? key}) : super(key: key);

  void _transition(BuildContext context) {
    addPost(Post(
        id: '0000',
        title: _titleController.text,
        content: _contentController.text,
        isAnonymous: _isAnonymous,
        user: user));
    Navigator.pop(context);
  }

  Widget _title() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 35),
      child: Column(
        children: const [
          MainTitle(
            title: "FREE BOARD",
            theme: Colors.white,
          ),
          SubTitle(
            title: "자유게시판",
            theme: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          // head
          _NewPostHead(controller: _titleController, isAnonymous : _isAnonymous),
          //textbox
          _NewPostBody(controller: _contentController),
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
          _title(),
          _body(context),
        ],
      ),
    );
  }
}

class _NewPostHead extends StatelessWidget {
  final TextEditingController controller;
  bool isAnonymous;

  _NewPostHead({required this.controller, required this.isAnonymous, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(5),
      height: 70,
      color: Colors.black,
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            child: Image.asset('images/default.jpg'),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(3),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: '제목',
                        hintStyle: TextStyle(fontSize: 15, color: Colors.white),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      controller: controller,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.camera_alt,
                      size: 20,
                      color: Colors.white,
                    ),
                    Checkbox(
                      value: isAnonymous,
                      activeColor: Colors.white,
                      checkColor: Colors.black,
                      onChanged: (bool? value) {
                        isAnonymous = value!;
                      },
                    ),
                    const Text("익명", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NewPostBody extends StatelessWidget {
  final TextEditingController controller;
  const _NewPostBody({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        color: Colors.black,
        child: TextField(
          controller: controller,
          style: TextStyle(color: Colors.white),
          maxLines: null,
          decoration: const InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
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
        fixedSize: Size(148, 34),
        primary: Colors.black,
        side: const BorderSide(
          color: Colors.white,
          width: 0.5,
        ),
      ),
      onPressed: _callback,
      child: const Text("글쓰기 완료"),
    );
  }
}
