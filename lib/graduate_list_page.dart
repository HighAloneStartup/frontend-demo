import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/user.dart';
import 'models/main_user.dart';
import 'models/badges.dart';
import 'styles/main_title_text.dart';
import 'styles/sub_title_text.dart';
import 'DMPage.dart';

class GraduateListPage extends StatefulWidget {
  final MainUser user;

  const GraduateListPage({Key? key, required this.user}) : super(key: key);

  @override
  State<GraduateListPage> createState() => _GraduateListPageState();
}

class _GraduateListPageState extends State<GraduateListPage> {
  final int yearNum = 3;

  Widget _title() {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
              color: Color(0xFF3D5D54),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              MainTitle(
                title: "STUDENT LIST",
                theme: Color(0xFF3D5D54),
              ),
              SubTitle(title: "학생부")
            ],
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CustomScrollView(
          slivers: <Widget>[
            ..._makeSection("졸업생 목록"),
          ],
        ),
      ),
    );
  }

  Future<List<User>> _getStudentList(int year) async {
    http.Response response = await http.get(
      Uri(
        scheme: 'http',
        host: 'ec2-44-242-141-79.us-west-2.compute.amazonaws.com',
        port: 9090,
        path: 'api/members/',
        queryParameters: {
          'gradeYear': '$year',
          'classGroup': '$year',
        },
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
        //print(parsed);
        return parsed.map((e) => User.fromJson(e)).toList();
      default:
        throw Exception('$statusCode');
    }
  }

  Widget _makeList(int year) {
    //return SliverToBoxAdapter(child: Text("나 여기있고, 너 거기있지"));
    return FutureBuilder(
      future: _getStudentList(year),
      builder: (context, AsyncSnapshot<List<User>> snapshot) {
        //print(snapshot.data);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SliverToBoxAdapter(
              child: Center(
                  child: CircularProgressIndicator(color: Color(0xFF3D5D54))));
        }
        if (snapshot.data == null) {
          return const SliverToBoxAdapter();
        }
        var students = snapshot.data;
        return SliverList(
          delegate: SliverChildListDelegate(students!.map((student) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: StudentCard(student), ///////////////
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DMPage(user: widget.user, opponent: student),
                    ),
                  );
                }, ////////////////////////////////////////
              ),
            );
          }).toList()),
        );
      },
    );
  }

  List<Widget> _makeSection(String title) {
    List<Widget> graduates = [];
    for (int i = 1; i < yearNum; i++) {
      graduates.add(_makeList((-1) * i));
    }
    return [
      SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFE4F0ED),
          ),
          child: MainTitle(
            title: title,
            size: 25,
            theme: const Color(0xFF3D5D54),
          ),
        ),
      ),
      const SliverToBoxAdapter(child: SizedBox(height: 10)),
      const SliverToBoxAdapter(child: SizedBox(height: 10)),
    ];
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

class StudentCard extends StatelessWidget {
  final User user;
  const StudentCard(this.user, {super.key});

  Widget _photo() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(user.photoUrl), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(25),
      ),
    );
  }

  Widget _badges() {
    return Row(
      children: user.authorities == null
          ? []
          : user.authorities!.map((e) {
              /*
              return SubTitle(
                title: Badge.badges[e]!,
              );
              */
              return Container(
                height: 20,
                margin: const EdgeInsets.symmetric(horizontal: 1),
                child: Image.asset(Badge.badges[e]),
              );
            }).toList(),
    );
  }

  Widget _profile() {
    return Row(
      children: [
        MainTitle(
          title: user.name,
          size: 18,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF3D5D54)),
                color: const Color.fromARGB(40, 97, 97, 97),
              ),
              child: const SubTitle(
                title: "미친건가 수능 일주일 밖에 안남았네...",
                size: 13,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //return MainTitle(title: user.name);
    return Row(
      children: [
        _photo(),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _badges(),
              const SizedBox(height: 3),
              _profile(),
            ],
          ),
        ),
      ],
    );
  }
}