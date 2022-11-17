import 'package:flutter/material.dart';
import 'package:high_alone_startup/models/main_user.dart';
import 'models/post.dart';
import 'post_page.dart';
import 'models/main_user.dart';

class ClassPostList extends StatelessWidget {
  final MainUser user;

  /// 테스트용 데이터
  final List<Post> postList;

  const ClassPostList(this.postList, {Key? key, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      padding: EdgeInsets.zero,
      itemCount: postList.length,
      itemBuilder: (context, index) => _PostWidget(
        postList[index],
        user: user,
      ),
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
    var photo = SizedBox(
      child: post.image == null
          ? Image.asset('assets/images/default.jpg')
          : Image.asset(post.image as String),
    );

    return TextButton(
      child: photo,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PostPage(post, user: user)),
        );
      },
    );
  }
}