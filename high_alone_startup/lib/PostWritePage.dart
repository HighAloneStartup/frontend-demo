import 'package:flutter/material.dart';
import './component/MainTitle.dart';
import './component/SubTitle.dart';

class PostWritePage extends StatelessWidget {
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

  final Widget _body = Container(
    child: Column(
      children: [
        Container(
          height: 500,
          margin: EdgeInsets.all(10),
          color: Colors.white,
          child: const TextField(
            maxLines: null,
            decoration: InputDecoration(
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        ElevatedButton(
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
      ],
    ),
  );

  PostWritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: double.infinity,
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
