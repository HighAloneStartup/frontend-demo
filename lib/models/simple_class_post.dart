import 'post.dart';

class SimpleClassPost {
  static const String defaultPhotoUrl =
      'https://www.bcm-institute.org/wp-content/uploads/2020/11/No-Image-Icon.png';
  final String id;
  final bool published;
  final String? image;
  final DateTime createdAt;
  final bool manyimages;

  SimpleClassPost({
    required this.id,
    required this.published,
    required this.image,
    required this.createdAt,
    required this.manyimages,
  });

  factory SimpleClassPost.fromJson(Map<String, dynamic> json) {
    String image = json['image'] ?? defaultPhotoUrl;
    image = image == "" ? defaultPhotoUrl : image;
    return SimpleClassPost(
      id: json['id'] as String,
      published: json['published'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String).toLocal(),
      image: image,
      manyimages: json['manyimages'] as bool,
    );
  }

  factory SimpleClassPost.fromPost(Post post) {
    int imageNum = post.images.length;
    return SimpleClassPost(
      id: post.id,
      published: post.published,
      image: imageNum == 0 ? null : post.images.first,
      createdAt: post.createdAt,
      manyimages: imageNum > 1,
    );
  }
}
