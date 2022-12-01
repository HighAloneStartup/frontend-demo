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
  final String photoUrl;

  static const String defaultPhotoUrl =
      'https://www.bcm-institute.org/wp-content/uploads/2020/11/No-Image-Icon.png';

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
    this.photoUrl = defaultPhotoUrl,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    //String uid = json['uid'] as String;
    List<dynamic> temp1 = json['authorities'] != null
        ? json['authorities'] as List<dynamic>
        : json['roles'] as List<dynamic>;
    List<Authority> temp2 = temp1.map((e) => Authority.fromJson(e)).toList();

    var _photoUrl = (json['photoUrl'] ?? defaultPhotoUrl) as String;

    return User(
      uid: json['email'] as String,
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
      photoUrl: _photoUrl,
    );
  }
}
