import 'package:flutter/material.dart';
import 'models/class.dart';
import 'widgets/main_title_text.dart';
import 'widgets/sub_title_text.dart';

class StudentListPage extends StatelessWidget {
  const StudentListPage({Key? key}) : super(key: key);
  void _onChooseClass(Class clas) {
    print("${clas.grade}학년 ${clas.classNum}반 학생 목록페이지로 이동");
  }

  Widget _title() {
    return Container(
      padding: const EdgeInsets.only(top: 35, bottom: 35),
      child: Column(
        children: const [
          MainTitle(
            title: "STUDENT LIST",
            theme: Colors.white,
          ),
          SubTitle(
            title: "학생부",
            theme: Colors.white,
          )
        ],
      ),
    );
  }

  Widget _body() {
    return Expanded(
      child: _ClassList(
        onChooseClass: _onChooseClass,
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
          _body(),
        ],
      ),
    );
  }
}

class _ClassList extends StatelessWidget {
  _ClassList({
    Key? key,
    required Function this.onChooseClass,
  }) : super(key: key);

  final Function onChooseClass;

  final List<Class> _firstGrade = [
    Class(grade: 1, classNum: 1, member: ['정동원A', "정동원B", "정동원C"]),
    Class(grade: 1, classNum: 2, member: ['정동원D', "정동원E", "정동원F"]),
    Class(grade: 1, classNum: 3, member: ['정동원G', "정동원H", "정동원I"]),
  ];
  final List<Class> _secondGrade = [
    Class(grade: 2, classNum: 1, member: ['황서진A', "황서진B", "황서진C"]),
    Class(grade: 2, classNum: 2, member: ['황서진D', "황서진E", "황서진F"]),
    Class(grade: 2, classNum: 3, member: ['황서진G', "황서진H", "황서진I"]),
  ];
  final List<Class> _thirdGrade = [
    Class(grade: 3, classNum: 1, member: ['손승표A', "손승표B", "손승표C"]),
    Class(grade: 3, classNum: 2, member: ['손승표D', "손승표E", "손승표F"]),
    Class(grade: 3, classNum: 3, member: ['손승표G', "손승표H", "손승표I"]),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        children: <Widget>[
          const MainTitle(
            title: "FIRST GRADE",
            size: 25,
            theme: Colors.white,
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                ..._firstGrade.map((clas) {
                  return TextButton(
                    onPressed: () => onChooseClass(clas),
                    child: SubTitle(
                      title: "${clas.grade}학년 ${clas.classNum}반",
                      size: 15,
                      theme: Colors.white,
                    ),
                  );
                })
              ],
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
          const MainTitle(
            title: "SECOND GRADE",
            size: 25,
            theme: Colors.white,
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                ..._secondGrade.map((clas) {
                  return TextButton(
                    onPressed: () => onChooseClass(clas),
                    child: SubTitle(
                      title: "${clas.grade}학년 ${clas.classNum}반",
                      size: 15,
                      theme: Colors.white,
                    ),
                  );
                })
              ],
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
          const MainTitle(
            title: "THIRD GRADE",
            size: 25,
            theme: Colors.white,
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                ..._thirdGrade.map((clas) {
                  return TextButton(
                    onPressed: () => onChooseClass(clas),
                    child: SubTitle(
                      title: "${clas.grade}학년 ${clas.classNum}반",
                      size: 15,
                      theme: Colors.white,
                    ),
                  );
                })
              ],
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ],
      ),
    );
  }
}
