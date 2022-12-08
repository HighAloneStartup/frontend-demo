class Comment {
  final String description;
  Comment({required this.description});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(description: json['description']);
  }
}
