import 'dart:io';

import 'package:flutter/material.dart';
import 'package:high_alone_startup/models/user.dart';
import 'models/post.dart';
import 'models/main_user.dart';
import 'post_page.dart';
import 'styles/main_title_text.dart';
import 'styles/sub_title_text.dart';
import 'styles/list_block.dart';

class PostList extends StatelessWidget {
  final MainUser user;

  /// 테스트용 데이터
  final List<Post> postList;

  const PostList(this.postList, {Key? key, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    postList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return ListView.separated(
      itemCount: postList.length,
      itemBuilder: (BuildContext context, int index) {
        return _PostWidget(
          postList[index],
          user: user,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          thickness: 1,
          height: 1,
          color: Color(0xFFE4F0ED),
        );
      },
    );
  }
}

class _PostWidget extends StatelessWidget {
  final MainUser user;
  final Post post;

  const _PostWidget(this.post, {Key? key, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var contents = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [],
    );

    var activate = Container(
      alignment: Alignment.bottomCenter,
      child: Row(
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
          SubTitle(
            title: "방금전",
            theme: Colors.grey,
          ),
        ],
      ),
    );

    return Container(
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      child: TextButton(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainTitle(
              title: "익명",
              size: 16,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 3),
              child: SubTitle(
                title: post.title,
                size: 16,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 3),
              child: SubTitle(
                title: post.description,
                size: 15,
                theme: Color.fromARGB(255, 128, 128, 128),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            activate,
          ],
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostPage(post, user: user)),
          );
        },
      ),
    );
  }
}
