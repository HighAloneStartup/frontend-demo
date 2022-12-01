class Authority {
  final String name;
  Authority(this.name);

  factory Authority.fromJson(Map<String, dynamic> json) {
    String _name = json["authority"] == null
        ? json["name"] as String
        : json["authority"] as String;
    return Authority(_name);
  }
}
