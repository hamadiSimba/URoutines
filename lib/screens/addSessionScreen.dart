import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uroutines/model/modules.dart';
import 'package:uroutines/model/session.dart';
import 'package:uroutines/widgets/appbar.dart';
import 'package:uroutines/widgets/bottomNavigation.dart';
import 'package:uroutines/widgets/inputField.dart';

import '../controller/sessionController.dart';
import '../utility/db.dart';
import '../utility/snackbar.dart';

class AddSession extends StatefulWidget {
  const AddSession({super.key});

  @override
  State<AddSession> createState() => _AddSessionState();
}

class _AddSessionState extends State<AddSession> {
  SessionController moduleController = Get.put(SessionController());
  final TextEditingController venue = TextEditingController();
  final TextEditingController courses = TextEditingController();
  int courseCount = 1;
  int courseAmount = 0;

  String courseName = "Courses";
  List<String> courseNameList = [];
  List<String> courseCodeList = [];

  DateTime time = DateTime.now();
  DateTime today = DateTime.now();
  // DateTime _selectedtime = DateTime.now();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _endTime = DateFormat("hh:mm a").format(DateTime.now()).toString();

  @override
  void initState() {
    refreshModules();
    super.initState();
  }

  int checkCode(String a) {
    int k = 0;
    for (int i = 0; i < courseNameList.length; i++) {
      if (a == courseNameList[i]) {
        setState(() {
          k = i;
        });
      }
    }
    return k;
  }

  refreshModules() async {
    List<Modules> x = await DbHelper.courseQuery();
    setState(() {
      for (int i = 0; i < x.length; i++) {
        courseNameList.add(x[i].courseName!);
        courseCodeList.add(x[i].courseCode!);
      }
    });
  }

  String moduleDay = "Mon";
  List<String> moduleDayList = [
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun",
  ];

  String sessionType = "Lecture";
  List<String> sessionTypeList = [
    "Lecture",
    "Practical",
    "Tutorial",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppHeader.appBar("Add Sessions"),
      body: Container(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.05,
              ),
              GestureDetector(
                onTap: () {
                  dialog(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  height: 60.0,
                  width: 120.0,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(137, 52, 240, 146),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      courseAmount == 0
                          ? "Click Here"
                          : "$courseCount Out of $courseAmount",
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              MyInputField(
                title: "Course Name",
                hint: courseName,
                widget: DropdownButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(
                    height: 0.0,
                  ),
                  style: const TextStyle(color: Colors.white, fontSize: 16.0),
                  items: courseNameList
                      .map<DropdownMenuItem<String>>(
                        (String e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(
                            e,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (String? value) {
                    setState(() {
                      courseName = value!;
                    });
                  },
                ),
              ),
              MyInputField(
                title: "Session Type",
                hint: sessionType,
                widget: DropdownButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(
                    height: 0.0,
                  ),
                  style: const TextStyle(color: Colors.white, fontSize: 16.0),
                  items: sessionTypeList
                      .map<DropdownMenuItem<String>>(
                        (String e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(
                            e,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (String? value) {
                    setState(() {
                      sessionType = value!;
                    });
                  },
                ),
              ),
              MyInputField(
                title: "Week Day",
                hint: moduleDay,
                widget: DropdownButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(
                    height: 0.0,
                  ),
                  style: const TextStyle(color: Colors.white, fontSize: 16.0),
                  items: moduleDayList
                      .map<DropdownMenuItem<String>>(
                        (String e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(
                            e,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (String? value) {
                    setState(() {
                      moduleDay = value!;
                    });
                  },
                ),
              ),
              MyInputField(
                title: "Starting Time",
                hint: _startTime,
                widget: IconButton(
                  onPressed: () {
                    _getTimeFromUser(isStartTime: true);
                  },
                  icon: const Icon(
                    Icons.access_time_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
              MyInputField(
                title: "Venue",
                hint: "Enter Class Room",
                controller: venue,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (courseCount != courseAmount) {
                        _validateData();
                      } else {
                        _validateData();
                        setState(() {
                          courseAmount = 0;
                        });
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BottomNavigation()),
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      height: 42.0,
                      width: 112.0,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _pickedTime();

    // ignore: use_build_context_synchronously
    String fotmatedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print("Time is Canceled!");
    } else if (isStartTime == true) {
      setState(() {
        _startTime = fotmatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = fotmatedTime;
      });
    } else {}
  }

  _pickedTime() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
          hour: int.parse(_startTime.split(":")[0]),
          minute: int.parse(_startTime.split(":")[1].split(" ")[0])),
    );
  }

  _validateData() {
    if (venue.text.isNotEmpty) {
      if (courseAmount == 0) {
        showSnackBar("Click Button on the Top", context, "Warning");
      } else {
        _addModuletoDb();
        venue.clear();
      }
    } else {
      showSnackBar("Please insert Class Room!", context, "Warning");
    }
  }

  dialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Set Number Of Courses",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          content: Container(
            height: 52.0,
            padding: const EdgeInsets.only(left: 14.0),
            margin: const EdgeInsets.only(top: 8.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.secondary,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextFormField(
              autofocus: false,
              keyboardType: TextInputType.phone,
              cursorColor: Colors.white,
              controller: courses,
              style: TextStyle(
                fontSize: 14.0,
                color: Theme.of(context).colorScheme.secondary,
              ),
              decoration: InputDecoration(
                hintText: "Enter Number of Courses",
                hintStyle: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.5)),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 0,
                  ),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 0,
                  ),
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  setState(() {
                    courseAmount = int.parse(courses.text);
                  });
                  Navigator.pop(context);
                },
                child: Text(
                  "Ok",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                )),
          ],
        );
      },
    );
  }

  _addModuletoDb() async {
    int value = await moduleController.addSession(
      sessions: Session(
        courseCode: courseCodeList[checkCode(courseName)],
        sessionType: sessionType,
        weekDay: moduleDay,
        startTime: twelveTotwentyFour(_startTime),
        venue: venue.text.toUpperCase(),
      ),
    );

    setState(() {
      courseCount++;
    });
    FlutterBackgroundService().invoke("refreshSession");
    showSnackBar("Course registered Sucessfully", context, "ok");
  }

  String twelveTotwentyFour(String time) {
    int hour = int.parse(time.split(":")[0]);
    int min = int.parse(time.split(":")[1].split(" ")[0]);
    String amPm = time.split(":")[1].split(" ")[1];

    print("am pm is $amPm");
    print("minutes is $min");
    print("hour is $hour");

    if (hour < 12 && amPm == "PM") {
      hour = hour + 12;
      if (min < 10) {
        if (hour < 10) {
          return "0$hour:0$min";
        } else {
          return "$hour:0$min";
        }
      } else {
        if (hour < 10) {
          return "0$hour:$min";
        } else {
          return "$hour:$min";
        }
      }
    } else if (amPm != "") {
      if (min < 10) {
        if (hour < 10) {
          return "0$hour:0$min";
        } else {
          return "$hour:0$min";
        }
      } else {
        if (hour < 10) {
          return "0$hour:$min";
        } else {
          return "$hour:$min";
        }
      }
    } else {
      if (min < 10) {
        if (hour < 10) {
          return "0$hour:0$min";
        } else {
          return "$hour:0$min";
        }
      } else {
        return "$hour:$min";
      }
    }
  }
}
