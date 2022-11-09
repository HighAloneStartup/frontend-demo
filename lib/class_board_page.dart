import 'package:flutter/material.dart';
import 'new_post_page.dart';
import 'styles/main_title_text.dart';
import 'styles/sub_title_text.dart';
import 'class_post_list.dart';
import 'models/post.dart';
import 'models/user.dart';

final Map<String, User> _users = {
  '손승표': User(name: '손승표', email: 'SSP@gmail.com'),
  '정동원': User(name: '정동원', email: 'JDW@gmail.com'),
  '황서진': User(name: '황서진', email: 'HSJ@gmail.com'),
};

class ClassBoardPage extends StatefulWidget {
  final int gradeYear;
  final int classGroup;
  const ClassBoardPage({Key? key, required this.gradeYear, required this.classGroup }) : super(key: key);

  @override
  State<ClassBoardPage> createState() => _PostListPageState(gradeYear : gradeYear, classGroup : classGroup);
}

class _PostListPageState extends State<ClassBoardPage> {
  final int gradeYear;
  final int classGroup;
  final _postList = [
    Post(
        id: '0000',
        user: _users['손승표']!,
        title: '체육복 빌려줄사람?',
        content: '3학년 1반으로 와주셈',
        isAnonymous: true,),
    Post(
        id: '0001',
        user: _users['정동원']!,
        title: '축구하러 갈사람?',
        content: '10분 뒤 운동장으로 집합 ㄱㄱ',
        isAnonymous: true,),
    Post(
        id: '0002',
        user: _users['손승표']!,
        title: '오늘 체육수업',
        content: '있었나 알려주실분?',
        isAnonymous: true,),
    Post(
        id: '0003',
        user: _users['황서진']!,
        title: '오늘 3반 생물수업 노트필기 적으신 분?',
        content: '있다면 보여 주실 천사 구함',
        isAnonymous: true,),
    Post(
        id: '0004',
        user: _users['정동원']!,
        title: '창고 뒤에서 담패핀 넘...',
        content: '누구냐? 누구냐? 누구냐? 누구냐? 누구냐? 누구냐? 누구냐? 누구냐? 누구냐? 누구냐?',
        isAnonymous: true,),
    Post(
        id: '0000',
        user: _users['손승표']!,
        title: '체육복 빌려줄사람?',
        content: '3학년 1반으로 와주셈',
        isAnonymous: true,),
    Post(
        id: '0001',
        user: _users['정동원']!,
        title: '축구하러 갈사람?',
        content: '10분 뒤 운동장으로 집합 ㄱㄱ',
        isAnonymous: true,),
    Post(
        id: '0002',
        user: _users['손승표']!,
        title: '오늘 체육수업',
        content: '있었나 알려주실분?',
        isAnonymous: true,),
    Post(
        id: '0003',
        user: _users['황서진']!,
        title: '오늘 3반 생물수업 노트필기 적으신 분?',
        content: '있다면 보여 주실 천사 구함',
        isAnonymous: true,),
    Post(
        id: '0004',
        user: _users['정동원']!,
        title: '창고 뒤에서 담패핀 넘...',
        content: '누구냐? 누구냐? 누구냐? 누구냐? 누구냐? 누구냐? 누구냐? 누구냐? 누구냐? 누구냐?',
        isAnonymous: true,),
    Post(
        id: '0000',
        user: _users['손승표']!,
        title: '체육복 빌려줄사람?',
        content: '3학년 1반으로 와주셈',
        isAnonymous: true,),
    Post(
        id: '0001',
        user: _users['정동원']!,
        title: '축구하러 갈사람?',
        content: '10분 뒤 운동장으로 집합 ㄱㄱ',
        isAnonymous: true,),
    Post(
        id: '0002',
        user: _users['손승표']!,
        title: '오늘 체육수업',
        content: '있었나 알려주실분?',
        isAnonymous: true,),
    Post(
        id: '0003',
        user: _users['황서진']!,
        title: '오늘 3반 생물수업 노트필기 적으신 분?',
        content: '있다면 보여 주실 천사 구함',
        isAnonymous: true,),
    Post(
        id: '0004',
        user: _users['정동원']!,
        title: '창고 뒤에서 담패핀 넘...',
        content: '누구냐? 누구냐? 누구냐? 누구냐? 누구냐? 누구냐? 누구냐? 누구냐? 누구냐? 누구냐?',
        isAnonymous: true,),
  ];

  _PostListPageState({required this.gradeYear, required this.classGroup});

  void _transition(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => NewPostPage(
            _addNewPost,
            user: User(name: '관리자', email: 'admin@gmail.com'),
          )),
    );
  }

  void _addNewPost(Post newPost) {
    setState(() {
      _postList.add(newPost);
    });
  }

  Widget _title() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MainTitle(
            title: "CLASS BOARD",
            theme: Colors.white,
          ),
          const SubTitle(
            title: "반 게시판",
            theme: Colors.white,
          ),
          MainTitle(
            title: "${gradeYear} - ${classGroup}",
            theme: Colors.white,
            size: 25,
          ),
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
          ClassPostList(_postList),
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
