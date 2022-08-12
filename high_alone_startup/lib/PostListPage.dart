import 'package:flutter/material.dart';
import './component/MainTitle.dart';
import './component/SubTitle.dart';

List<_Post> _postList = [
  _Post(
    id: 0x0000,
    content: "체육복 빌려줄사람?",
  ),
  _Post(
    id: 0x0001,
    content: "축구하러 갈사람? 10분 뒤 운동장으로 집합 ㄱㄱ",
  ),
  _Post(
    id: 0x0000,
    content: "오늘 체육수업 있었는지 알려주실분?",
  ),
  _Post(
    id: 0x0002,
    content: "오늘 3반 생물수업 노트필기 보여 주실 천사 구함",
  ),
  _Post(
    id: 0x0001,
    content: "창고 뒤에서 담패핀 쉑 누구냐? 꽁초는 양심적으로 치우삼",
  ),
  _Post(
    id: 0x0000,
    content: "체육복 빌려줄사람?",
  ),
  _Post(
    id: 0x0001,
    content: "축구하러 갈사람? 10분 뒤 운동장으로 집합 ㄱㄱ",
  ),
  _Post(
    id: 0x0000,
    content: "오늘 체육수업 있었는지 알려주실분?",
  ),
  _Post(
    id: 0x0002,
    content: "오늘 3반 생물수업 노트필기 보여 주실 천사 구함",
  ),
  _Post(
    id: 0x0001,
    content: "창고 뒤에서 담패핀 쉑 누구냐? 꽁초는 양심적으로 치우삼",
  ),
  _Post(
    id: 0x0000,
    content: "체육복 빌려줄사람?",
  ),
  _Post(
    id: 0x0001,
    content: "축구하러 갈사람? 10분 뒤 운동장으로 집합 ㄱㄱ",
  ),
  _Post(
    id: 0x0000,
    content: "오늘 체육수업 있었는지 알려주실분?",
  ),
  _Post(
    id: 0x0002,
    content: "오늘 3반 생물수업 노트필기 보여 주실 천사 구함",
  ),
  _Post(
    id: 0x0001,
    content: "창고 뒤에서 담패핀 쉑 누구냐? 꽁초는 양심적으로 치우삼",
  ),
  _Post(
    id: 0x0000,
    content: "체육복 빌려줄사람?",
  ),
  _Post(
    id: 0x0001,
    content: "축구하러 갈사람? 10분 뒤 운동장으로 집합 ㄱㄱ",
  ),
  _Post(
    id: 0x0000,
    content: "오늘 체육수업 있었는지 알려주실분?",
  ),
  _Post(
    id: 0x0002,
    content: "오늘 3반 생물수업 노트필기 보여 주실 천사 구함",
  ),
  _Post(
    id: 0x0001,
    content: "창고 뒤에서 담패핀 쉑 누구냐? 꽁초는 양심적으로 치우삼",
  ),
];

Map<int, Map<String, String>> users = {
  0x0000: {'name': '손승표', 'photo': '손승표.jpg'},
  0x0001: {'name': '정동원', 'photo': '정동원.jpg'},
  0x0002: {'name': '황서진', 'photo': '황서진.jpg'},
};

class PostListPage extends StatelessWidget {
  final Widget _title = Container(
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

  final Widget _body = Expanded(
    //height: double.infinity,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          child: ListView.separated(
            itemCount: _postList.length,
            itemBuilder: (BuildContext context, int index) {
              return _postList[index];
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                thickness: 1,
                height: 1,
                color: Colors.white,
              );
            },
          ),
        ),
        Positioned(
          bottom: 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(148, 34),
              primary: Colors.black,
              side: const BorderSide(
                color: Colors.white,
                width: 0.5,
              ),
            ),
            onPressed: () {
              return print("글쓰기로 이동");
            },
            child: Text("글쓰기"),
          ),
        ),
      ],
    ),
  );

  PostListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          children: [
            _title,
            _body,
          ],
        ),
      ),
    );
  }
}

class _Post extends StatelessWidget {
  final String? _name;
  final String? _photo;
  final String _content;

  _Post({
    Key? key,
    required int id,
    required String content,
  })  : _name = users[id]?['name'] as String,
        _photo = 'images/${users[id]?['photo'] as String}',
        _content = content,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var photo = SizedBox(
      width: 60,
      height: 60,
      child: (_photo == null)
          ? Image.asset('images/default.jpg')
          : Image.asset(_photo as String),
    );
    var contents = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubTitle(
            title: (_name == null) ? "익명" : _name as String,
            theme: Colors.white,
          ),
          SubTitle(
            title: _content,
            theme: Colors.white,
          ),
        ],
      ),
    );

    var activate = Container(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: const [
          Icon(
            size: 10,
            Icons.thumb_up,
            color: Colors.white,
          ),
          Icon(
            size: 10,
            Icons.comment,
            color: Colors.white,
          ),
          Icon(
            size: 10,
            Icons.star,
            color: Colors.white,
          ),
        ],
      ),
    );

    return Container(
      padding: const EdgeInsets.all(5),
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [photo, contents, activate],
      ),
    );
  }
}
