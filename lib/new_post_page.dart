import 'package:flutter/material.dart';
import 'styles/main_title_text.dart';
import 'styles/sub_title_text.dart';
import './models/post.dart';
import './models/main_user.dart';

class NewPostPage extends StatelessWidget {
  final MainUser user;
  final Function addPost;
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  bool _published = true;

  NewPostPage(this.addPost, {required this.user, Key? key}) : super(key: key);

  void _transition(BuildContext context) {
    if (_titleController.text.isEmpty) {
      _showDialog("제목을 입력해주세요", context: context);
      return;
    }
    if (_contentController.text.isEmpty) {
      _showDialog("내용을 입력해주세요", context: context);
      return;
    }
    addPost(Post(
      id: '0000',
      title: _titleController.text,
      description: _contentController.text,
      published: _published,
      user: user,
      createdAt: DateTime.now(),
    ));
    Navigator.pop(context);
  }

  void _showDialog(String contents, {required context}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(contents),
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

  Widget _title() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          MainTitle(
            title: "WRITE POST",
            theme: Color(0xFF3D5D54),
          ),
          SubTitle(
            title: "글쓰기",
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
          _NewPostHead(controller: _titleController, isAnonymous: _published),
          //textbox
          SizedBox(height: 10),
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

class _NewPostHead extends StatelessWidget {
  final TextEditingController controller;
  bool isAnonymous;

  _NewPostHead({required this.controller, required this.isAnonymous, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 70,
      child: Row(
        children: [
          SizedBox(
            height: 70,
            width: 70,
            child: Image.network(
                'https://www.bcm-institute.org/wp-content/uploads/2020/11/No-Image-Icon.png'),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: TextField(
                      style: const TextStyle(fontFamily: 'Roboto'),
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                        hintText: '제목',
                        hintStyle: TextStyle(fontFamily: 'Roboto'),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF3D5D54)),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF3D5D54)),
                        ),
                      ),
                      controller: controller,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.camera_alt,
                        size: 20,
                      ),
                    ),
                    Checkbox(
                      value: isAnonymous,
                      activeColor: Colors.white,
                      checkColor: Colors.grey,
                      onChanged: (bool? value) {},
                    ),
                    const MainTitle(
                      title: "익명",
                      size: 15,
                      theme: Color(0xFF3D5D54),
                    ),
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
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xFFE4F0ED),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.black, fontFamily: 'Roboto'),
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
        fixedSize: const Size(148, 34),
        backgroundColor: const Color(0xFF3D5D54),
        side: const BorderSide(
          color: Colors.white,
          width: 0.5,
        ),
      ),
      onPressed: _callback,
      child: const MainTitle(
        title: "글쓰기",
        size: 15,
        theme: Colors.white,
      ),
    );
  }
}
