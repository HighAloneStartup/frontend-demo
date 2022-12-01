import 'package:flutter/material.dart';
import 'package:high_alone_startup/models/main_user.dart';
import 'models/simple_class_post.dart';
import 'models/post.dart';
import 'post_page.dart';

class ClassPostList extends StatelessWidget {
  final MainUser user;

  /// 테스트용 데이터
  final List<SimpleClassPost> postList;

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
  final SimpleClassPost post;

  const _PostWidget(this.post, {Key? key, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var photo = post.repPhotoUrl == null
        ? Image.network(
            Post.defaultPhotoUrl,
            fit: BoxFit.fill,
          )
        : Image.network(post.repPhotoUrl!);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        backgroundColor: Colors.white,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PostPage(post.id, user: user)),
        );
      },
      child: photo,
    );
  }
}
