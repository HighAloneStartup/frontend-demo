import 'package:high_alone_startup/models/authority.dart';

class User {
  final String uid;
  final String name;
  final String email;
  List<Authority>? authorities = [];
  int? gradeYear;
  int? classGroup;
  int? attendanceNumber;
  int? generationNumber;
  int? studentNumber;
  String? birthday;
  String? phoneNumber;
  String? photoUrl;

  User({
    required this.uid,
    required this.name,
    required this.email,
    this.authorities,
    this.gradeYear,
    this.classGroup,
    this.attendanceNumber,
    this.generationNumber,
    this.studentNumber,
    this.birthday,
    this.phoneNumber,
    this.photoUrl,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    String timestamp = json['uid'] as String;

    List<dynamic> temp1 = json['authorities'] as List<dynamic>;

    List<Authority> temp2 = temp1.map((e) => Authority.fromJson(e)).toList();
    return User(
      uid: timestamp,
      name: json['name'] as String,
      email: json['email'] as String,
      authorities: temp2,
      gradeYear: json['gradeYear'] as int?,
      classGroup: json['classGroup'] as int?,
      attendanceNumber: json['attendanceNumber'] as int?,
      generationNumber: json['generationNumber'] as int?,
      studentNumber: json['studentNumber'] as int?,
      birthday: json['birthday'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      photoUrl: json['photoUrl'] as String?,
    );
  }
}
