import 'user.dart';

class Post {
  final String id;
  final String title;
  final String description;
  final bool published;
  final User? user;
  final List<String> images;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.title,
    required this.description,
    required this.published,
    required this.createdAt,
    this.user,
    required this.images,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    List<String> _images =
        (json['images'] as List<dynamic>).map((e) => e as String).toList();
    //print(_images);
    return Post(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      published: json['published'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      images: _images,
    );
  }
}
