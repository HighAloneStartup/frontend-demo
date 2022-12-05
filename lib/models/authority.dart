class Authority {
  final String id;
  final String name;
  Authority({required this.id, required this.name});

  factory Authority.fromJson(Map<String, dynamic> json) {
    return Authority(
      id: json['id'],
      name: json['name'],
    );
  }
}
