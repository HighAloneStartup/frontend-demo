import 'user.dart';
import 'like.dart';
import 'comment.dart';

class Post {
  static const String defaultPhotoUrl =
      'https://www.bcm-institute.org/wp-content/uploads/2020/11/No-Image-Icon.png';
  final String id;
  final String title;
  final String description;
  final bool published;
  final String uid;
  final String userName;
  final String? userPhotoUrl;
  final bool anonymous;
  final DateTime createdAt;
  final int likes;
  final bool liked;
  final List<String> images;
  final List<Comment> comments;

  Post({
    required this.id,
    required this.title,
    required this.description,
    required this.published,
    required this.uid,
    required this.userName,
    required this.userPhotoUrl,
    required this.anonymous,
    required this.createdAt,
    required this.likes,
    this.liked = false,
    required this.images,
    required this.comments,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    List<String> _images =
        (json['images'] as List<dynamic>).map((e) => e as String).toList();
    //List<Like> _likes = (json['likes'] as List<dynamic>).map((e) => Like.fromJson(e)).toList();
    List<Comment> _comments = (json['comments'] as List<dynamic>)
        .map((e) => Comment.fromJson(e))
        .toList();
    return Post(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      published: json['published'] as bool,
      uid: json['uid'] as String,
      userName: json['userName'] as String,
      userPhotoUrl: json['userPhotoUrl'] as String?,
      anonymous: json['anonymous'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String).toLocal(),
      likes: 0, //json['likes'] as int,
      liked: json['liked'] as bool,
      images: _images,
      comments: _comments,
    );
  }
  factory Post.defaultPost() {
    return Post(
      id: "",
      title: "",
      description: "",
      published: false,
      uid: "",
      userName: "",
      userPhotoUrl: null,
      anonymous: true,
      createdAt: DateTime(9999),
      likes: 0,
      liked: false,
      images: [],
      comments: [],
    );
  }
}
