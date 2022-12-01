import 'post.dart';

class SimplePost {
  static const String defaultPhotoUrl =
      'https://www.bcm-institute.org/wp-content/uploads/2020/11/No-Image-Icon.png';
  final String id;
  final String title;
  final String description;
  final bool published;
  final String userName;
  final String? userPhotoUrl;
  final bool anonymous;
  final DateTime createdAt;
  final int likes;
  final int images;
  final int comments;

  SimplePost({
    required this.id,
    required this.title,
    required this.description,
    required this.published,
    required this.userName,
    this.userPhotoUrl,
    required this.anonymous,
    required this.createdAt,
    required this.likes,
    required this.images,
    required this.comments,
  });

  factory SimplePost.fromJson(Map<String, dynamic> json) {
    return SimplePost(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      published: json['published'] as bool,
      userName: json['userName'] as String,
      userPhotoUrl: json['userPhotoUrl'] as String?,
      anonymous: json['anonymous'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String).toLocal(),
      likes: json['likes'] as int,
      images: json['images'] as int,
      comments: json['comments'] as int,
    );
  }

  factory SimplePost.fromPost(Post post) {
    return SimplePost(
      id: post.id,
      title: post.title,
      description: post.description,
      published: post.published,
      userName: post.userName,
      userPhotoUrl: post.userPhotoUrl,
      anonymous: post.anonymous,
      createdAt: post.createdAt,
      likes: 0,
      images: post.images.length,
      comments: post.comments.length,
    );
  }
}
