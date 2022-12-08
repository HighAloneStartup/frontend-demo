import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:path_provider/path_provider.dart';

import 'class_board_page.dart';
import 'styles/sub_title_text.dart';
import 'models/user.dart';
import 'models/main_user.dart';
import 'models/badges.dart';

class MyPage extends StatefulWidget {
  final MainUser user;
  MyPage({super.key, required this.user});
  final picker = ImagePicker();

  @override
  State<MyPage> createState() => _MyPageState(user: user);
}

class _MyPageState extends State<MyPage> {
  _MyPageState({required this.user});

  final MainUser user;
  Map<String, dynamic> change = {};

  String name = "seo jin";
  String email = "swiftie1230@naver.com";
  String password = "swiftie1230";
  /* roles 형태 */
  List<String> roles = [];
  /* int 형태 이거 맞나 */
  int gradeYear = 0;
  int classGroup = 0;
  int attendanceNumber = 0;
  int generationNumber = 0;
  int studentNumber = 0;
  /* date 형태 ? string 형태 ? */
  String birthday = "";
  String phoneNumber = "010-8891-2306";
  String photoUrl = "";
  bool isRemove = false;
  bool whetherDelete = false;

  XFile? _pickedFile;
  NetworkImage _downloadedImg = const NetworkImage(
      'https://www.bcm-institute.org/wp-content/uploads/2020/11/No-Image-Icon.png');

  Future<User> _getUserData() async {
    http.Response response = await http.get(
      Uri(
        scheme: 'http',
        host: 'ec2-44-242-141-79.us-west-2.compute.amazonaws.com',
        port: 9090,
        path: 'api/members/mine',
        /*
        queryParameters: {
          'gradeYear': '$gradeYear',
          'classGroup': '$classGroup',
        },
        */
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': user.token,
      },
    );

    var statusCode = response.statusCode;
    var responseBody = utf8.decode(response.bodyBytes);

    switch (statusCode) {
      case 200:
        var parsed = jsonDecode(responseBody) as Map<String, dynamic>;
        return User.fromJson(parsed);
      default:
        throw Exception('$statusCode');
    }
  }

  /* 유저 데이터를 저장하는 함수*/
  /* 파리미터 수정 필요*/
  Future _uploadUserData() async {
    change['roles'] = roles.map((e) => "ROLE_$e").toList();
    http.Response response = await http.put(
      Uri(
        scheme: 'http',
        host: 'ec2-44-242-141-79.us-west-2.compute.amazonaws.com',
        port: 9090,
        path: 'api/members/mine',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': user.token,
      },
      body: json.encoder.convert(change),
    );

    var statusCode = response.statusCode;

    switch (statusCode) {
      case 200:
        return;
      default:
        throw Exception('$statusCode');
    }
  }

  Future<List<String>> postImage(String path) async {
    var dio = Dio();
    dio.options.contentType = 'multipart/form-data';
    dio.options.headers = {
      'Authorization': widget.user.token,
    };

    var formData = FormData.fromMap({
      'images': [MultipartFile.fromFileSync(path)],
    });

    // 업로드 요청
    final response = await dio.post(
        'http://ec2-44-242-141-79.us-west-2.compute.amazonaws.com:9090/api/upload/',
        data: formData);

    var statusCode = response.statusCode;
    var responseBody = response.data;

    switch (statusCode) {
      case 200:
        var parsed = responseBody;
        return parsed.map<String>((e) => e as String).toList();
      default:
        throw Exception('$statusCode');
    }
  }

  _showBottomSheet() {
    isRemove = false;
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () => _getCameraImage(),
              style: ElevatedButton.styleFrom(
                primary: const Color(0xff3D5D54),
              ),
              child: const Text('사진찍기'),
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              thickness: 1,
            ),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () => _getPhotoLibraryImage(),
              style: ElevatedButton.styleFrom(
                primary: const Color(0xff3D5D54),
              ),
              child: const Text('라이브러리에서 불러오기'),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        );
      },
    );
  }

  _getCameraImage() async {
    Navigator.pop(context);
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 200,
      maxWidth: 200,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    } else {
      if (kDebugMode) {
        print('이미지 선택안함');
      }
    }
  }

  _getPhotoLibraryImage() async {
    Navigator.pop(context);
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 200,
      maxWidth: 200,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    } else {
      if (kDebugMode) {
        print('이미지 선택안함');
      }
    }
  }

  List<Widget> _showGraduateClasses() {
    bool isGraduate = User.checkGraduate(roles);
    if (!isGraduate) {
      return [
        Container(
          height: 15,
          margin: const EdgeInsets.only(left: 10),
          alignment: const Alignment(-1.0, 0.0),
          child: const Text(
            'GRADE',
            style: TextStyle(
              color: Color(0xff3D5D54),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 5,
          ),
          child: Text("$gradeYear"),
        ),
        const SizedBox(
          height: 30.0,
        ),
        Container(
          height: 15,
          margin: const EdgeInsets.only(left: 10),
          alignment: const Alignment(-1.0, 0.0),
          child: const Text(
            'CLASS',
            style: TextStyle(
              color: Color(0xff3D5D54),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 5,
          ),
          child: Text("$classGroup"),
        ),
      ];
    }

    return [
      Container(
        height: 15,
        margin: const EdgeInsets.only(left: 10),
        alignment: const Alignment(-1.0, 0.0),
        child: const Text(
          'GRADUATE CLASSES',
          style: TextStyle(
            color: Color(0xff3D5D54),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(
        height: 10.0,
      ),
      TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ClassBoardPage(
                    user: user, year: 17, gradeYear: 1, classGroup: 1)),
          );
        },
        child: const Text("17년도 1학년 1반"),
      ),
      TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ClassBoardPage(
                    user: user, year: 18, gradeYear: 2, classGroup: 2)),
          );
        },
        child: const Text("18년도 2학년 2반"),
      ),
      TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ClassBoardPage(
                    user: user, year: 19, gradeYear: 3, classGroup: 3)),
          );
        },
        child: const Text("19년도 3학년 3반"),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUserData(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            width: double.infinity,
            child: Center(
                child: CircularProgressIndicator(
              color: Color(0xFF3D5D54),
            )),
          );
        }
        if (snapshot.data == null) {
          return const SubTitle(title: "데이터를 불러오는데 실패하였습니다.");
        }

        User currentUser = snapshot.data as User;
        photoUrl = isRemove ? User.defaultPhotoUrl : currentUser.photoUrl;

        name = currentUser.name;
        email = currentUser.email;
        /* roles 형태 */
        roles = currentUser.authorities != null ? currentUser.authorities! : [];
        /* int 형태 이거 맞나 */
        gradeYear = currentUser.gradeYear != null ? currentUser.gradeYear! : 0;
        classGroup =
            currentUser.classGroup != null ? currentUser.classGroup! : 0;
        attendanceNumber = currentUser.attendanceNumber != null
            ? currentUser.attendanceNumber!
            : 0;
        generationNumber = currentUser.generationNumber != null
            ? currentUser.generationNumber!
            : 0;
        studentNumber =
            currentUser.studentNumber != null ? currentUser.studentNumber! : 0;
        /* date 형태 ? string 형태 ? */
        birthday = currentUser.birthday != null ? currentUser.birthday! : "";
        phoneNumber =
            currentUser.phoneNumber != null ? currentUser.phoneNumber! : "";
        _downloadedImg = NetworkImage(photoUrl);

        return Padding(
          padding: const EdgeInsets.only(right: 30.0, left: 30.0),
          child: ListView(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              if (_pickedFile != null)
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2,
                      color: const Color(0xff3D5D54),
                    ),
                    image: DecorationImage(
                      image: FileImage(File(_pickedFile!.path)),
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              else
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2,
                      color: const Color(0xff3D5D54),
                    ),
                    image: DecorationImage(
                      image: _downloadedImg,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _showBottomSheet,
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xff3D5D54),
                      // textColor: Colors.white,
                    ),
                    child: const Text(
                      "이미지 선택",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _pickedFile = null;
                        isRemove = true;
                      });
                    },
                    child: const Text(
                      "이미지 삭제",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50.0,
              ),
              Container(
                height: 15,
                margin: const EdgeInsets.only(left: 10),
                alignment: const Alignment(-1.0, 0.0),
                child: const Text(
                  'NICKNAME',
                  style: TextStyle(
                    color: Color(0xff3D5D54),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 5,
                ),
                child: Text(name),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                height: 15,
                margin: const EdgeInsets.only(left: 10),
                alignment: const Alignment(-1.0, 0.0),
                child: const Text(
                  'EMAIL',
                  style: TextStyle(
                    color: Color(0xff3D5D54),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 5,
                ),
                child: Text(email),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                height: 15,
                margin: const EdgeInsets.only(left: 10),
                alignment: const Alignment(-1.0, 0.0),
                child: const Text(
                  'ROLES',
                  style: TextStyle(
                    color: Color(0xff3D5D54),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 5,
                ),
                width: 30,
                height: 30,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: roles
                      .map((role) => Image.asset(
                            Badge.badges[role]!,
                            height: 30,
                            width: 30,
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              ..._showGraduateClasses(),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                height: 15,
                margin: const EdgeInsets.only(left: 10),
                alignment: const Alignment(-1.0, 0.0),
                child: const Text(
                  'ATTENDANCE NUMBER',
                  style: TextStyle(
                    color: Color(0xff3D5D54),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 5,
                ),
                child: Text("$attendanceNumber"),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                height: 15,
                margin: const EdgeInsets.only(left: 10),
                alignment: const Alignment(-1.0, 0.0),
                child: const Text(
                  'GENERATION NUMBER',
                  style: TextStyle(
                    color: Color(0xff3D5D54),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 5,
                ),
                child: Text("$generationNumber"),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                height: 15,
                margin: const EdgeInsets.only(left: 10),
                alignment: const Alignment(-1.0, 0.0),
                child: const Text(
                  'STUDENT NUMBER',
                  style: TextStyle(
                    color: Color(0xff3D5D54),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 5,
                ),
                child: Text("$studentNumber"),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                height: 15,
                margin: const EdgeInsets.only(left: 10),
                alignment: const Alignment(-1.0, 0.0),
                child: const Text(
                  'BIRTHDAY',
                  style: TextStyle(
                    color: Color(0xff3D5D54),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 5,
                ),
                child: Text(birthday),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                height: 15,
                margin: const EdgeInsets.only(left: 10),
                alignment: const Alignment(-1.0, 0.0),
                child: const Text(
                  'PHONE NUMBER',
                  style: TextStyle(
                    color: Color(0xff3D5D54),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 5,
                ),
                child: Text(phoneNumber),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                height: 50,
                width: double.infinity,
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 5,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff3D5D54),
                    // textColor: Colors.white,
                  ),
                  child: const Text(
                    '저장하기',
                    style: TextStyle(color: Colors.white),
                  ),
                  // name instead of the actual result! : without parentheses
                  onPressed: () async {
                    if (_pickedFile != null) {
                      change['photoUrl'] =
                          (await postImage(_pickedFile!.path)).first;
                      print(change['photoUrl']);
                    }
                    if (change.isNotEmpty) {
                      await _uploadUserData();
                    }
                    change = {};
                    isRemove = false;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      }),
    );
  }
}
