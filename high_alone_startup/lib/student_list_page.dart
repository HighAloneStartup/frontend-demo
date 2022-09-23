import 'package:flutter/material.dart';
import 'models/class.dart';
import 'models/user.dart';
import 'styles/main_title_text.dart';
import 'styles/sub_title_text.dart';
import 'styles/list_block.dart';

class StudentListPage extends StatelessWidget {
  const StudentListPage({Key? key}) : super(key: key);

  Widget _title() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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

  Widget _body(BuildContext context) {
    void _onChooseClass(Class classInfo) {
      print("${classInfo.grade}학년 ${classInfo.classNum}반 학생 목록페이지로 이동");
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => _StudentList(
                  classInfo: classInfo,
                )),
      );
    }

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
          _body(context),
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
    Class(grade: 1, classNum: 1, member: [
      User(id: "0012", name: '정동원A'),
      User(id: "0013", name: "정동원B"),
      User(id: "0013", name: "정동원C"),
    ]),
    Class(grade: 1, classNum: 2, member: [
      User(id: "0013", name: '정동원D'),
      User(id: "0013", name: "정동원E"),
      User(id: "0013", name: "정동원F"),
    ]),
    Class(grade: 1, classNum: 3, member: [
      User(id: "0013", name: '정동원G'),
      User(id: "0013", name: "정동원H"),
      User(id: "0013", name: "정동원I"),
    ]),
  ];
  final List<Class> _secondGrade = [
    Class(grade: 2, classNum: 1, member: [
      User(id: "0013", name: '황서진A'),
      User(id: "0013", name: "황서진B"),
      User(id: "0013", name: "황서진C")
    ]),
    Class(grade: 2, classNum: 2, member: [
      User(id: "0013", name: '황서진D'),
      User(id: "0013", name: "황서진E"),
      User(id: "0013", name: "황서진F")
    ]),
    Class(grade: 2, classNum: 3, member: [
      User(id: "0013", name: '황서진G'),
      User(id: "0013", name: "황서진H"),
      User(id: "0013", name: "황서진I")
    ]),
  ];
  final List<Class> _thirdGrade = [
    Class(grade: 3, classNum: 1, member: [
      User(id: "0013", name: '손승표A'),
      User(id: "0013", name: "손승표B"),
      User(id: "0013", name: "손승표C"),
    ]),
    Class(grade: 3, classNum: 2, member: [
      User(id: "0013", name: '손승표D'),
      User(id: "0013", name: "손승표E"),
      User(id: "0013", name: "손승표F"),
    ]),
    Class(grade: 3, classNum: 3, member: [
      User(id: "0013", name: '손승표G'),
      User(id: "0013", name: "손승표H"),
      User(id: "0013", name: "손승표I"),
    ]),
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
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                ..._firstGrade.map((classInfo) {
                  return TextButton(
                    child: SubTitle(
                      title: "${classInfo.grade}학년 ${classInfo.classNum}반",
                      size: 15,
                      theme: Colors.white,
                    ),
                    onPressed: () => onChooseClass(classInfo),
                  );
                })
              ],
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
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
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
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
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
          ),
        ],
      ),
    );
  }
}

class _StudentList extends StatelessWidget {
  final Class classInfo;

  const _StudentList({Key? key, required Class this.classInfo})
      : super(key: key);

  Widget _title() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          MainTitle(
            title: "STUDENT LIST",
            theme: Colors.white,
          ),
          SubTitle(
            title: "학생부",
            theme: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainTitle(
              title: "${classInfo.grade} - ${classInfo.classNum}",
              size: 25.0,
              theme: Colors.white,
            ),
            Expanded(
              child: ListView(
                children: [
                  ...classInfo.member.map((member) {
                    return TextButton(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: ListBlock(
                          start: Container(
                            width: 60,
                            margin: const EdgeInsets.only(right: 10),
                            height: 60,
                            child: Image.network(
                                'https://www.tibs.org.tw/images/default.jpg'),
                          ),
                          center: SubTitle(
                            title: member.name,
                            size: 15,
                            theme: Colors.white,
                          ),
                          end: const Icon(Icons.message, color: Colors.white),
                        ),
                      ),
                      onPressed: () => print(member.name),
                    );
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            _title(),
            _body(),
          ],
        ),
      ),
    );
  }
}
