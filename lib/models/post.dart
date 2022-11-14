import 'user.dart';

class Post {
  final String id;
  final String title;
  final String content;
  final bool isAnonymous;
  final User user;
  final String? image;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.isAnonymous,
    required this.user,
    this.image,
  });
}
