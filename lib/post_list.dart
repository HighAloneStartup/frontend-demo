import 'package:flutter/material.dart';
import 'models/simple_post.dart';
import 'models/post.dart';
import 'models/main_user.dart';
import 'post_page.dart';
import 'styles/main_title_text.dart';
import 'styles/sub_title_text.dart';

class PostList extends StatelessWidget {
  final MainUser user;

  /// 테스트용 데이터
  final List<SimplePost> postList;
  final String boardName;
  final String boardUrl;

  const PostList(
    this.postList, {
    Key? key,
    required this.user,
    required this.boardName,
    required this.boardUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    postList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return ListView.separated(
      itemCount: postList.length,
      itemBuilder: (BuildContext context, int index) {
        return _PostWidget(
          postList[index],
          user: user,
          boardName: boardName,
          boardUrl: boardUrl,
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
  final SimplePost post;
  final String boardName;
  final String boardUrl;

  const _PostWidget(
    this.post, {
    Key? key,
    required this.user,
    required this.boardName,
    required this.boardUrl,
  }) : super(key: key);

  String makeCreatedTime(DateTime time) {
    bool isToday = (time.year == DateTime.now().year) &&
        (time.month == DateTime.now().month) &&
        (time.day == DateTime.now().day);
    return isToday
        ? "${time.hour}:${time.minute}"
        : "${time.month}/${time.day}";
  }

  @override
  Widget build(BuildContext context) {
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
          MainTitle(title: post.likes.toString(), theme: Colors.red, size: 15),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  const Icon(
                    Icons.comment,
                    size: 15,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 2),
                  MainTitle(
                    title: post.comments.toString(),
                    theme: Colors.grey,
                    size: 15,
                  ),
                ],
              ),
            ),
          ),
          SubTitle(
            title: makeCreatedTime(post.createdAt),
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
              title: post.anonymous ? "익명" : post.userName,
              size: 16,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 3),
              child: SubTitle(
                title: post.title,
                size: 16,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 3),
              child: SubTitle(
                title: post.description,
                size: 15,
                theme: const Color.fromARGB(255, 128, 128, 128),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            activate,
          ],
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PostPage(
                      postId: post.id,
                      user: user,
                      boardName: boardName,
                      boardUrl: "boards/$boardUrl",
                    )),
          );
        },
      ),
    );
  }
}
