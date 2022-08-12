import 'package:flutter/material.dart';
import './component/MainTitle.dart';
import './component/SubTitle.dart';

class PostWritePage extends StatelessWidget {
  Widget _title() {
    return Container(
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
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(5),
            height: 70,
            color: Colors.white,
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
                          margin: const EdgeInsets.all(5),
                          child: const TextField(),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.camera_alt,
                            size: 20,
                          ),
                          Checkbox(
                            value: false,
                            onChanged: (bool? value) {
                              print("ischecked");
                            },
                          ),
                          const Text("익명"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //textbox
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: const TextField(
                maxLines: null,
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          //button
          Container(
            margin: const EdgeInsets.all(40),
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
                Navigator.pop(context);
              },
              child: const Text("글쓰기 완료"),
            ),
          ),
        ],
      ),
    );
  }

  PostWritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
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
