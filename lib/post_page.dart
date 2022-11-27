import 'package:flutter/material.dart';
import 'package:high_alone_startup/models/main_user.dart';
import './styles/main_title_text.dart';
import './styles/sub_title_text.dart';
import './models/post.dart';
import './models/main_user.dart';

class PostPage extends StatefulWidget {
  final MainUser user;
  final Post post;

  const PostPage(this.post, {Key? key, required this.user}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState(post, user: user);
}

class _PostPageState extends State<PostPage> {
  final MainUser user;
  final Post post;
  bool isAnonymous = true;
  final commentController = TextEditingController();

  _PostPageState(this.post, {required this.user});

  void _addComment(String comment) {
    setState(() {
      commentController.clear();
    });
  }

  Widget _title() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          MainTitle(
            title: "FREE BOARD",
            theme: Color(0xFF3D5D54),
          ),
          SubTitle(
            title: "전체 게시판",
          )
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            _PostHead(post: post),
            const SizedBox(height: 30),
            _PostBody(post: post),
          ],
        ),
      ),
    );
  }

  Widget _commentTextLine() {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: const Color.fromARGB(20, 97, 97, 97),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Checkbox(
            value: isAnonymous,
            activeColor: Colors.white,
            checkColor: Colors.grey,
            onChanged: ((bool? value) {
              setState(() {
                isAnonymous = value!;
              });
            }),
          ),
          const MainTitle(
            title: "익명",
            size: 15,
            theme: Color(0xFF3D5D54),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: TextField(
              controller: commentController,
              style: const TextStyle(color: Colors.black, fontFamily: "Roboto"),
              cursorColor: Colors.black,
              maxLines: 1,
              decoration: const InputDecoration(
                hintText: "Write a comment",
                hintStyle: TextStyle(color: Colors.grey, fontFamily: "Roboto"),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3D5D54)),
            onPressed: () => _addComment(commentController.text),
            child: const MainTitle(
              title: "작성",
              size: 15,
              theme: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _title(),
                _body(context),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _commentTextLine(),
            ),
          ],
        ),
      ),
    );
  }
}

class _PostHead extends StatelessWidget {
  final Post post;

  const _PostHead({required this.post, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MainTitle(
            title: "익명",
            size: 24,
          ),
          const SizedBox(height: 10),
          SubTitle(
            title: post.title,
            overflow: TextOverflow.clip,
            size: 18,
          ),
          const SizedBox(height: 5),
          SubTitle(
            title: post.description,
            overflow: TextOverflow.clip,
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.favorite,
                size: 15,
                color: Colors.red,
              ),
              const SizedBox(width: 2),
              const MainTitle(title: "3", theme: Colors.red, size: 15),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.comment,
                        size: 15,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 2),
                      MainTitle(title: "3", theme: Colors.grey, size: 15),
                    ],
                  ),
                ),
              ),
              const SubTitle(
                title: "방금전",
                theme: Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PostBody extends StatelessWidget {
  final Post post;
  const _PostBody({required this.post, Key? key}) : super(key: key);

  final List<String> comments = const [
    "헐 저두",
    "저두 22",
    "쪽지 보냈습니다!",
    "와.. 존경.. 저도 후배로 들어가고 싶어요 ㅠㅠ",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: comments
          .map(
            (comment) => Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: const Color(0xFFE4F0ED),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MainTitle(
                    title: "익명",
                    size: 15,
                  ),
                  const SizedBox(height: 5),
                  SubTitle(
                    title: comment,
                    overflow: TextOverflow.clip,
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
