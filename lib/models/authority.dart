class Authority {
  final String name;
  Authority(this.name);

  factory Authority.fromJson(Map<String, dynamic> json) {
    return Authority(json["authority"] as String);
  }
}
