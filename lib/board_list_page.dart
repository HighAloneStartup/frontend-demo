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
            theme: Color(0xFF3D5D54),
          ),
          SubTitle(
            title: "게시판",
          )
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    void onChooseBoard(bool isClassBoard, String boardName, String url,
        int? gradeYear, int? classGroup) {
      if (isClassBoard) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ClassBoardPage(
                  user: user,
                  year: 22,
                  gradeYear: gradeYear!,
                  classGroup: classGroup!)),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PostListPage(
                    user: user,
                    boardName: boardName,
                    boardUrl: url,
                  )),
        );
      }
    }

    return Expanded(
      child: _BoardList(
        onChooseBoard: onChooseBoard,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
  final List<Map<String, dynamic>> _openBorad = [
    {
      "name": "전체 게시판",
      "url": "all",
      "isGrid": false,
    },
    {
      "name": "1학년 게시판",
      "url": "firstgrade",
      "isGrid": false,
    },
    {
      "name": "2학년 게시판",
      "url": "secondgrade",
      "isGrid": false,
    },
    {
      "name": "3학년 게시판",
      "url": "thirdgrade",
      "isGrid": false,
    },
    {
      "name": "게임 게시판",
      "url": "gameclub",
      "isGrid": false,
    },
    {
      "name": "푸드 게시판",
      "url": "foodclub",
      "isGrid": false,
    },
    {
      "name": "독서 게시판",
      "url": "bookclub",
      "isGrid": false,
    },
  ];
  final List<Map<String, dynamic>> _closedBoard = [
    {
      "name": "1학년 1반",
      "url": "20101",
      "isGrid": true,
      "gradeYear": 1,
      "classGroup": 1
    },
    {
      "name": "1학년 2반",
      "url": "20102",
      "isGrid": true,
      "gradeYear": 1,
      "classGroup": 2
    },
    {
      "name": "1학년 3반",
      "url": "20103",
      "isGrid": true,
      "gradeYear": 1,
      "classGroup": 3
    },
    {
      "name": "2학년 1반",
      "url": "20201",
      "isGrid": true,
      "gradeYear": 2,
      "classGroup": 1
    },
    {
      "name": "2학년 2반",
      "url": "20202",
      "isGrid": true,
      "gradeYear": 2,
      "classGroup": 2
    },
    {
      "name": "2학년 3반",
      "url": "20203",
      "isGrid": true,
      "gradeYear": 2,
      "classGroup": 3
    },
    {
      "name": "3학년 1반",
      "url": "20301",
      "isGrid": true,
      "gradeYear": 3,
      "classGroup": 1
    },
    {
      "name": "3학년 2반",
      "url": "20302",
      "isGrid": true,
      "gradeYear": 3,
      "classGroup": 2
    },
    {
      "name": "3학년 3반",
      "url": "20303",
      "isGrid": true,
      "gradeYear": 3,
      "classGroup": 3
    },
  ];

  List<Widget> _makeSection(
      String title, List<Map<String, dynamic>> boardlist) {
    return [
      SliverToBoxAdapter(
        child: Container(
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color(0xFFE4F0ED),
            borderRadius: BorderRadius.circular(10),
          ),
          child: MainTitle(
            title: title,
            size: 25,
            theme: const Color(0xFF3D5D54),
          ),
        ),
      ),
      SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 3,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => _makeBoardButton(
              boardlist[index]["name"] as String,
              boardlist[index]["isGrid"] as bool,
              boardlist[index]['url'] as String,
              boardlist[index]['gradeYear'] as int?,
              boardlist[index]['classGroup'] as int?),
          childCount: boardlist.length,
        ),
      ),
    ];
  }

  Widget _makeBoardButton(
    String title,
    bool isClassBoard,
    String url,
    int? gradeYear,
    int? classGroup,
  ) {
    return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SubTitle(
                title: title,
                size: 18,
              ),
              const SubTitle(title: ">"),
            ],
          ),
        ),
        onPressed: () =>
            onChooseBoard(isClassBoard, title, url, gradeYear, classGroup),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomScrollView(
        slivers: [
          ..._makeSection("열린 게시판", _openBorad),
          const SliverToBoxAdapter(
              child: SizedBox(
            height: 60,
          )),
          ..._makeSection("닫힌 게시판", _closedBoard),
        ],
      ),
    );
  }
}
