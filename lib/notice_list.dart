import 'package:flutter/material.dart';
import 'models/simple_post.dart';
import 'models/post.dart';
import 'models/main_user.dart';
import 'notice_page.dart';
import 'styles/main_title_text.dart';
import 'styles/sub_title_text.dart';

class NoticeList extends StatelessWidget {
  final MainUser user;

  /// 테스트용 데이터
  final List<SimplePost> postList;

  const NoticeList(this.postList, {Key? key, required this.user})
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
  final SimplePost post;

  const _PostWidget(this.post, {Key? key, required this.user})
      : super(key: key);

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
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
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
                builder: (context) => NoticePage(post.id, user: user)),
          );
        },
      ),
    );
  }
}
