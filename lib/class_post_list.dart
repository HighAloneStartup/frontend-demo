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
    return CustomScrollView(
      slivers: [
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) => _PostWidget(
              postList[index],
              user: user,
            ),
            childCount: postList.length,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
        )
      ],
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
    var photo = post.images.isEmpty
        ? Image.asset(
            'assets/images/default.jpg',
            fit: BoxFit.fill,
          )
        : Image.network(post.images[0]);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        backgroundColor: Colors.white,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PostPage(post, user: user)),
        );
      },
      child: photo,
    );
  }
}
