import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:high_alone_startup/models/main_user.dart';
import './styles/main_title_text.dart';
import './styles/sub_title_text.dart';
import './models/post.dart';
import './models/comment.dart';
import 'models/DB.dart';
import 'edit_post_page.dart';

class PostPage extends StatefulWidget {
  final MainUser user;
  final String boardName;
  final String boardUrl;
  final String postId;

  const PostPage({
    Key? key,
    required this.user,
    required this.boardUrl,
    required this.postId,
    required this.boardName,
  }) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  Post? post;
  List<Comment> comments = [];

  Future<Post> _getPost(String id) async {
    http.Response response = await http.get(
      Uri(
        scheme: 'http',
        host: 'ec2-44-242-141-79.us-west-2.compute.amazonaws.com',
        port: 9090,
        path: 'api/${widget.boardUrl}/$id',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': widget.user.token,
      },
    );

    var statusCode = response.statusCode;
    var responseBody = utf8.decode(response.bodyBytes);

    switch (statusCode) {
      case 200:
        var parsed = jsonDecode(responseBody);
        post = Post.fromJson(parsed);
        return Post.fromJson(parsed);
      default:
        DB.errorCode(statusCode, context);
        throw Exception('$statusCode');
    }
  }

  Future<Post> _modifyPost(String id) async {
    http.Response response = await http.put(
      Uri(
        scheme: 'http',
        host: 'ec2-44-242-141-79.us-west-2.compute.amazonaws.com',
        port: 9090,
        path: 'api/${widget.boardUrl}/$id',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': widget.user.token,
      },
    );

    var statusCode = response.statusCode;
    var responseBody = utf8.decode(response.bodyBytes);

    switch (statusCode) {
      case 200:
        var parsed = jsonDecode(responseBody) as Map<String, dynamic>;
        return Post.fromJson(parsed);
      default:
        DB.errorCode(statusCode, context);
        throw Exception('$statusCode');
    }
  }

  Future<Post> _deletePost(String id) async {
    http.Response response = await http.delete(
      Uri(
        scheme: 'http',
        host: 'ec2-44-242-141-79.us-west-2.compute.amazonaws.com',
        port: 9090,
        path: 'api/${widget.boardUrl}/$id',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': widget.user.token,
      },
    );

    var statusCode = response.statusCode;
    var responseBody = utf8.decode(response.bodyBytes);

    switch (statusCode) {
      case 200:
        var parsed = jsonDecode(responseBody) as Map<String, dynamic>;
        return Post.fromJson(parsed);
      default:
        DB.errorCode(statusCode, context);
        throw Exception('$statusCode');
    }
  }

  void _addComment(String comment) {
    DB.putComment(
      postId: widget.postId,
      boardUrl: widget.boardUrl,
      description: comment,
      user: widget.user,
      context: context,
    );
    setState(() {
      comments.add(Comment(description: comment));
    });
  }

  void _modifyCallback(Post editedPost) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                EditPostPage(_modifyCallback, user: widget.user, post: post!)));
  }

  void _deleteCallback() {}

  void pubLike() {
    DB.putLike(
      postId: widget.postId,
      boardUrl: widget.boardUrl,
      user: widget.user,
      context: context,
    );
  }

  Widget _title() {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
              color: Color(0xFF3D5D54),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MainTitle(
                title: "BOARD",
                theme: Color(0xFF3D5D54),
              ),
              SubTitle(
                title: widget.boardName,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: FutureBuilder(
            future: _getPost(widget.postId),
            builder: (context, snapshot) {
              //print(snapshot.error);
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  width: double.infinity,
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Color(0xFF3D5D54),
                  )),
                );
              }
              if (snapshot.data == null) {
                return const SubTitle(title: "데이터를 불러오는데 실패하였습니다.");
              }
              post = snapshot.data as Post;
              comments = post!.comments;
              return ListView(
                children: [
                  _PostHead(
                    post: post!,
                    callback: pubLike,
                  ),
                  const SizedBox(height: 30),
                  _PostBody(
                    post: post!,
                    comments: comments,
                  ),
                ],
              );
            }),
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
              child: _CommentTextLine(
                addComment: _addComment,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PostHead extends StatefulWidget {
  final Post post;
  final Function callback;

  const _PostHead({required this.post, required this.callback, Key? key})
      : super(key: key);

  @override
  State<_PostHead> createState() =>
      _PostHeadState(liked: post.liked, likes: post.likes);
}

class _PostHeadState extends State<_PostHead> {
  bool liked;
  int likes;
  _PostHeadState({required this.liked, required this.likes});
  String makeCreatedTime(DateTime time) {
    return "${time.year % 100}/${time.month}/${time.day} ${time.hour}:${time.minute}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainTitle(
            title: widget.post.anonymous ? "익명" : widget.post.userName,
            size: 24,
          ),
          const SizedBox(height: 10),
          Container(
            alignment: Alignment.center,
            height: widget.post.images.isEmpty ? 0 : 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return Image.network(widget.post.images[index]);
              },
              itemCount: widget.post.images.length,
            ),
          ),
          const SizedBox(height: 15),
          SubTitle(
            title: widget.post.title,
            overflow: TextOverflow.clip,
            size: 18,
          ),
          const SizedBox(height: 15),
          SubTitle(
            title: widget.post.description,
            overflow: TextOverflow.clip,
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    if (liked) {
                      likes--;
                    } else {
                      likes++;
                    }
                    liked = !liked;
                    widget.callback();
                  });
                },
                icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.favorite,
                      size: 15,
                      color: liked ? Colors.red : Colors.grey,
                    ),
                    const SizedBox(width: 2),
                    MainTitle(
                      title: widget.post.liked == liked
                          ? widget.post.likes.toString()
                          : likes.toString(),
                      theme: liked ? Colors.red : Colors.grey,
                      size: 15,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
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
                        title: widget.post.comments.length.toString(),
                        theme: Colors.grey,
                        size: 15,
                      ),
                    ],
                  ),
                ),
              ),
              SubTitle(
                title: makeCreatedTime(widget.post.createdAt),
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
  final List<Comment> comments;

  const _PostBody({required this.post, required this.comments, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...comments.map(
          (comment) => Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.all(15),
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
                  title: comment.description,
                  overflow: TextOverflow.clip,
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}

class _CommentTextLine extends StatefulWidget {
  final void Function(String) addComment;
  const _CommentTextLine({super.key, required this.addComment});

  @override
  State<_CommentTextLine> createState() => __CommentTextLineState();
}

class __CommentTextLineState extends State<_CommentTextLine> {
  bool isAnonymous = true;
  final commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 208, 208, 208),
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
              backgroundColor: const Color(0xFF3D5D54),
            ),
            onPressed: () {
              setState(() {
                widget.addComment(commentController.text);
                commentController.clear();
              });
            },
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
}
