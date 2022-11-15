import 'user.dart';

class MainUser extends User {
  final String token;

  MainUser(
      {required super.name,
      required super.email,
      required this.token,
      super.authorities,
      super.gradeYear,
      super.classGroup});

  factory MainUser.fromJson(Map<String, dynamic> json) {
    return MainUser(
      name: json['name'] as String,
      email: json['email'] as String,
      token: "$json['tokenType'] $json['accessToken']",
      //authorities: json['authorities']?.cast<List<String>>(),
      gradeYear: json['gradeYear']?.cast<int>(),
      classGroup: json['classGroup']?.cast<int>(),
    );
  }
}
