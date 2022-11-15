import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'post_list_page.dart';
import 'class_board_page.dart';
import 'models/main_user.dart';
import 'styles/main_title_text.dart';
import 'styles/sub_title_text.dart';

class BoardListPage extends StatelessWidget {
  final MainUser user;

  const BoardListPage({Key? key, required this.user}) : super(key: key);

  Widget _title() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          MainTitle(
            title: "BOARDS",
            theme: Colors.white,
          ),
          SubTitle(
            title: "게시판",
            theme: Colors.white,
          )
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    void _onChooseBoard(bool isClassBoard) {
      if (isClassBoard) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ClassBoardPage(user: user, gradeYear: 2, classGroup: 10)),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PostListPage(user: user)),
        );
      }
    }

    return Expanded(
      child: _BoardList(
        onChooseBoard: _onChooseBoard,
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

class _BoardList extends StatelessWidget {
  _BoardList({
    Key? key,
    required Function this.onChooseBoard,
  }) : super(key: key);

  final Function onChooseBoard;

  Widget _makeSection(String title, List<Widget> children) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: MainTitle(
              title: title,
              size: 25,
              theme: Colors.white,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _makeBoardButton(String title, bool isClassBoard) {
    return TextButton(
      child: Container(
        alignment: Alignment.centerLeft,
        child: MainTitle(
          title: title,
          size: 18,
          theme: Colors.white,
        ),
      ),
      onPressed: () => onChooseBoard(isClassBoard),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        children: <Widget>[
          _makeSection("열린 게시판", <Widget>[
            _makeBoardButton("전체 게시판", false),
            _makeBoardButton("학년별 게시판", false),
            _makeBoardButton("반별 게시판", false),
            _makeBoardButton("게임 게시판", false),
            _makeBoardButton("푸드 게시판", false),
          ]),
          _makeSection("닫힌 게시판", <Widget>[
            _makeBoardButton("2학년 10반", true),
            _makeBoardButton("독서 동아리", false),
          ]),
        ],
      ),
    );
  }
}
