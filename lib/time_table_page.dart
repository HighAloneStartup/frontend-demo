// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'styles/sub_title_text.dart';

import 'package:high_alone_startup/models/main_user.dart';

List week = ['mon', 'tue', 'wed', 'thu', 'fri'];
var kColumnLength = 22;
double kFirstColumnHeight = 20;
double kBoxSize = 52;

// 시간표 메인 화면
class TimeTablePage extends StatefulWidget {
  const TimeTablePage({
    Key? key,
    required this.user,
  }) : super(key: key);
  final MainUser user;

  @override
  State<TimeTablePage> createState() => _TimeTablePageState();
}

class _TimeTablePageState extends State<TimeTablePage> {
  final Map<String, Color> colorMapping = {
    "국어": Color.fromARGB(255, 199, 164, 112),
    "수학": Color.fromARGB(255, 105, 156, 180),
    "영어": Color.fromARGB(255, 216, 213, 179),
    "물리": Color.fromARGB(255, 173, 145, 177),
    "화학": Color.fromARGB(255, 242, 170, 165),
    "체육": Color.fromARGB(255, 83, 96, 173),
    "기술가정": Color.fromARGB(255, 112, 86, 76),
    "생물": Color.fromARGB(255, 112, 161, 114),
  };

  Map<String, dynamic> timeTableMap = {};

  Future<Map<String, dynamic>> _getTimeTable() async {
    http.Response response = await http.get(
      Uri(
        scheme: 'http',
        host: 'ec2-44-242-141-79.us-west-2.compute.amazonaws.com',
        port: 9090,
        path: 'api/timetable',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': widget.user.token,
      },
    );

    var statusCode = response.statusCode;
    var responseBody = utf8.decode(response.bodyBytes);

    switch (statusCode) {
      case 200:
        var parsed = jsonDecode(responseBody) as Map<String, dynamic>;
        //print(parsed);
        return parsed; //.remove("name");
      default:
        throw Exception('$statusCode');
    }
  }

  List<Color> colorTimeTable(List dayClass) {
    return dayClass.map((e) => colorMapping[e as String]!).toList();
  }

  List<Widget> buildDayColumn(int index, List dayClass) {
    List dayColors = colorTimeTable(dayClass);
    return [
      const VerticalDivider(
        color: Colors.grey,
        width: 0,
      ),
      Expanded(
        flex: 4,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 20,
                  child: Text(
                    '${week[index]}',
                  ),
                ),
                ...List.generate(
                  kColumnLength,
                  (index) {
                    if (index % 2 == 0) {
                      return const Divider(
                        color: Colors.grey,
                        height: 0,
                      );
                    }
                    return Container(
                      height: kBoxSize,
                      width: 66, //kColumnLength as double,
                      color:
                          index ~/ 2 < 8 ? dayColors[index ~/ 2] : Colors.white,
                      child: index ~/ 2 < 8
                          ? Text(dayClass[index ~/ 2],
                              style: const TextStyle(
                                fontSize: 10,
                              ))
                          : Container(),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    ];
  }

  Expanded buildTimeColumn() {
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: kFirstColumnHeight,
          ),
          ...List.generate(
            kColumnLength,
            (index) {
              if (index % 2 == 0) {
                return const Divider(
                  color: Colors.grey,
                  height: 0,
                );
              }
              return SizedBox(
                height: kBoxSize,
                child: Center(child: Text('${index ~/ 2 + 1}')),
              );
            },
          ),
        ],
      ),
    );
  }

  /*
  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push는 Future를 반환합니다. Future는 선택 창에서
    // Navigator.pop이 호출된 이후 완료될 것입니다.
    final result = await Navigator.push(
      context,
      // 다음 단계에서 SelectionScreen를 만들 것입니다.
      MaterialPageRoute(builder: (context) => const AddSchedulePage()),
    );

    //Scaffold.of(context)
    print(result.toString());
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '2022년 2학기',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue[600],
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  '시간표',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
                /*
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            _navigateAndDisplaySelection(context);
                          },
                          icon: const Icon(Icons.add_box_outlined),
                        ),
                        IconButton(
                          onPressed: () {
                            print('SEE SCHEDULE LIST BUTTON CLICKED!');
                          },
                          icon: const Icon(Icons.list),
                        ),
                      ],
                    ),
                    */
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: _getTimeTable(),
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

                  timeTableMap = snapshot.data as Map<String, dynamic>;

                  return Container(
                    height: kColumnLength / 2 * kBoxSize + kColumnLength,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        buildTimeColumn(),
                        ...buildDayColumn(
                          0,
                          timeTableMap[week[0]],
                        ),
                        ...buildDayColumn(
                          1,
                          timeTableMap[week[1]],
                        ),
                        ...buildDayColumn(
                          2,
                          timeTableMap[week[2]],
                        ),
                        ...buildDayColumn(
                          3,
                          timeTableMap[week[3]],
                        ),
                        ...buildDayColumn(
                          4,
                          timeTableMap[week[4]],
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 시간표 추가 화면
class AddSchedulePage extends StatefulWidget {
  const AddSchedulePage({Key? key}) : super(key: key);

  @override
  State<AddSchedulePage> createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  ClassInfo classInfo = ClassInfo(' ', ' ', 0, 0, 0);
  final double _kItemExtent = 32.0;

  int _selectedDay = 0;
  int _selectedTimeFrom = 0;
  int _selectedTimeTill = 0;

  final List<String> _day = <String>[
    '월요일',
    '화요일',
    '수요일',
    '목요일',
    '금요일',
  ];

  final List<String> _classTime = <String>[
    '1교시',
    '2교시',
    '3교시',
    '4교시',
    '5교시',
    '6교시',
    '7교시',
    '8교시',
    '9교시',
  ];

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0, left: 30.0, right: 30.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Add Subject',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  // border: OutlineInputBorder(),
                  labelText: '과목',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insert some texts';
                  }
                  return null;
                },
                /*
                onSaved: (value) {
                  classInfo.className = value as String;
                  print(classInfo.className);
                },
                */
                onChanged: (value) {
                  classInfo.className = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  // border: OutlineInputBorder(),
                  labelText: '선생님',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insert some texts';
                  }
                  return null;
                },
                /*
                onSaved: (value) {
                  classInfo.teacher = value as String;
                  print(classInfo.teacher);
                },
                */
                onChanged: (value) {
                  classInfo.teacher = value;
                },
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                '수업 요일과 교시를 선택해 주세요',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black38,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    // Display a CupertinoPicker with list of fruits.
                    onPressed: () => _showDialog(
                      CupertinoPicker(
                        magnification: 1.22,
                        squeeze: 1.2,
                        useMagnifier: true,
                        itemExtent: _kItemExtent,
                        // This is called when selected item is changed.
                        onSelectedItemChanged: (int selectedItem) {
                          setState(() {
                            _selectedDay = selectedItem;
                            classInfo.day = selectedItem;
                          });
                        },
                        children:
                            List<Widget>.generate(_day.length, (int index) {
                          return Center(
                            child: Text(
                              _day[index],
                            ),
                          );
                        }),
                      ),
                    ),
                    // This displays the selected fruit name.
                    child: Text(
                      _day[_selectedDay],
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    // Display a CupertinoPicker with list of fruits.
                    onPressed: () => _showDialog(
                      CupertinoPicker(
                        magnification: 1.22,
                        squeeze: 1.2,
                        useMagnifier: true,
                        itemExtent: _kItemExtent,
                        // This is called when selected item is changed.
                        onSelectedItemChanged: (int selectedItem) {
                          setState(() {
                            _selectedTimeFrom = selectedItem;
                            classInfo.timeFrom = selectedItem;
                          });
                        },
                        children: List<Widget>.generate(_classTime.length,
                            (int index) {
                          return Center(
                            child: Text(
                              _classTime[index],
                            ),
                          );
                        }),
                      ),
                    ),
                    // This displays the selected fruit name.
                    child: Text(
                      _classTime[_selectedTimeFrom],
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Text(
                    '-',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    // Display a CupertinoPicker with list of fruits.
                    onPressed: () => _showDialog(
                      CupertinoPicker(
                        magnification: 1.22,
                        squeeze: 1.2,
                        useMagnifier: true,
                        itemExtent: _kItemExtent,
                        // This is called when selected item is changed.
                        onSelectedItemChanged: (int selectedItem) {
                          setState(() {
                            _selectedTimeTill = selectedItem;
                            classInfo.timeTill = selectedItem;
                          });
                        },
                        children: List<Widget>.generate(_classTime.length,
                            (int index) {
                          return Center(
                            child: Text(
                              _classTime[index],
                            ),
                          );
                        }),
                      ),
                    ),
                    // This displays the selected fruit name.
                    child: Text(
                      _classTime[_selectedTimeTill],
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black, //background color of button
                    // elevation: 3, //elevation of button
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 15, right: 150, left: 150),
                  ),
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context, classInfo);
                    });
                  },
                  child: const Text('추가')),
            ],
          ),
        ),
      ),
    );
  }
}

class ClassInfo {
  String className;
  String teacher;
  int day;
  int timeFrom;
  int timeTill;
  // int? timeBlockIdx;

  ClassInfo(
    this.className,
    this.teacher,
    this.day,
    this.timeFrom,
    this.timeTill,
  );

  /*
  computeTimeTableIdx() {
    if (Day == 0) {
      
    }
  }
  */

  @override
  String toString() {
    return '( 과목명: ' +
        className +
        ', 선생님: ' +
        teacher +
        ', 요일:' +
        '$day' +
        ', 시작교시: '
            '$timeFrom' +
        ', 종료교시: '
            '$timeTill)';
  }
}
