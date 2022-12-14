import 'user.dart';

class MainUser extends User {
  final String token;

  MainUser(
      {required super.uid,
      required super.name,
      required super.email,
      required this.token,
      super.authorities,
      super.gradeYear,
      super.classGroup});

  factory MainUser.fromJson(Map<String, dynamic> json) {
    List<dynamic> temp = json['roles'] as List<dynamic>;
    List<String> roles = temp.map((e) => e.split('_')[1] as String).toList();
    return MainUser(
      uid: json['email'] as String, //json["uid"] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      token: "${json['tokenType']} ${json['accessToken']}",
      authorities: roles,
    );
  }
}
