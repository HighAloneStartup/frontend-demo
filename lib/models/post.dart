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
  final User user;
  final bool anonymous;
  final DateTime createdAt;
  final List<Like> likes;
  final List<String> images;
  final List<Comment> comments;

  Post({
    required this.id,
    required this.title,
    required this.description,
    required this.published,
    required this.user,
    required this.anonymous,
    required this.createdAt,
    required this.likes,
    required this.images,
    required this.comments,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    List<String> _images =
        (json['images'] as List<dynamic>).map((e) => e as String).toList();
    List<Like> _likes =
        (json['likes'] as List<dynamic>).map((e) => Like.fromJson(e)).toList();
    List<Comment> _comments = (json['comments'] as List<dynamic>)
        .map((e) => Comment.fromJson(e))
        .toList();
    return Post(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      published: json['published'] as bool,
      user: User.fromJson(json['user']),
      anonymous: json['anonymous'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String).toLocal(),
      likes: _likes,
      images: _images,
      comments: _comments,
    );
  }
}
