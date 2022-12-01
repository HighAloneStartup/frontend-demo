import 'post.dart';

class SimpleClassPost {
  static const String defaultPhotoUrl =
      'https://www.bcm-institute.org/wp-content/uploads/2020/11/No-Image-Icon.png';
  final String id;
  final bool published;
  final String? repPhotoUrl;
  final DateTime createdAt;
  final bool isMultiPhoto;

  SimpleClassPost({
    required this.id,
    required this.published,
    required this.repPhotoUrl,
    required this.createdAt,
    required this.isMultiPhoto,
  });

  factory SimpleClassPost.fromJson(Map<String, dynamic> json) {
    return SimpleClassPost(
      id: json['id'] as String,
      published: json['published'] as bool,
      repPhotoUrl: json['repPhotoUrl'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String).toLocal(),
      isMultiPhoto: json['isMultiPhoto'] as bool,
    );
  }

  factory SimpleClassPost.fromPost(Post post) {
    int imageNum = post.images.length;
    return SimpleClassPost(
      id: post.id,
      published: post.published,
      repPhotoUrl: imageNum == 0 ? null : post.images.first,
      createdAt: post.createdAt,
      isMultiPhoto: imageNum > 1,
    );
  }
}
