import 'package:flutter/material.dart';
import 'models/post.dart';
import 'post_page.dart';
import 'styles/sub_title_text.dart';
import 'styles/list_block.dart';

class PostList extends StatelessWidget {
  /// 테스트용 데이터
  final List<Post> postList;

  const PostList(this.postList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: postList.length,
      itemBuilder: (BuildContext context, int index) {
        return _PostWidget(postList[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          thickness: 1,
          height: 1,
          color: Colors.white,
        );
      },
    );
  }
}

class _PostWidget extends StatelessWidget {
  final Post post;

  const _PostWidget(Post this.post, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var photo = Container(
      width: 60,
      margin: const EdgeInsets.only(right: 5),
      height: 60,
      child: post.image == null
          ? Image.asset('assets/images/default.jpg')
          : Image.asset(post.image as String),
    );
    var contents = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubTitle(
          title: post.isAnonymous ? "익명" : post.user.name,
          theme: Colors.white,
        ),
        SubTitle(
          title: post.content,
          theme: Colors.white,
        ),
      ],
    );

    var activate = Container(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: const [
          Icon(
            size: 10,
            Icons.thumb_up,
            color: Colors.white,
          ),
          Icon(
            size: 10,
            Icons.comment,
            color: Colors.white,
          ),
          Icon(
            size: 10,
            Icons.star,
            color: Colors.white,
          ),
        ],
      ),
    );

    return Container(
      padding: const EdgeInsets.all(5),
      width: double.infinity,
      height: 70,
      child: TextButton(
        child: ListBlock(
          start: photo,
          center: contents,
          end: activate,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostPage(post)),
          );
        },
      ),
    );
  }
}
