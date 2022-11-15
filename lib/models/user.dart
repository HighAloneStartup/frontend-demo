class User {
  final String name;
  final String email;
  List<String>? authorities = [];
  int? gradeYear;
  int? classGroup;

  User(
      {required this.name,
      required this.email,
      this.authorities,
      this.gradeYear,
      this.classGroup});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      email: json['email'] as String,
      //authorities: json['authorities']?.cast<List<String>>(),
      gradeYear: json['gradeYear'] as int?,
      classGroup: json['classGroup'] as int?,
    );
  }
}
