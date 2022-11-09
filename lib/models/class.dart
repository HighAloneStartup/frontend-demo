import './user.dart';

class Class {
  final int gradeYear;
  final int classGroup;
  final List<User> member;
  Class(
      {required this.gradeYear,
      required this.classGroup,
      required this.member});

  factory Class.fromJson(int gradeYear, int classGroup, dynamic json) {
    print(json.runtimeType);
    //print(json[0]);
    var students = json as List<dynamic>;
    return Class(
      gradeYear: gradeYear,
      classGroup: classGroup,
      member: [
        ...students.map((student) {
          return User.fromJson(student);
        })
      ],
    );
  }
}
