import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uroutines/controller/moduleController.dart';
import 'package:uroutines/model/modules.dart';
import 'package:uroutines/utility/db.dart';
import 'package:uroutines/widgets/appbar.dart';
import 'package:uroutines/widgets/bottomNavigation.dart';
import 'package:uroutines/widgets/inputField.dart';

import '../utility/snackbar.dart';

class AddModules extends StatefulWidget {
  const AddModules({super.key});

  @override
  State<AddModules> createState() => _AddModulesState();
}

class _AddModulesState extends State<AddModules> {
  ModuleController moduleController = Get.put(ModuleController());
  final TextEditingController courseName = TextEditingController();
  final TextEditingController courseCode = TextEditingController();
  final TextEditingController courseLecturer = TextEditingController();
  final TextEditingController courses = TextEditingController();
  int courseCount = 1;
  int courseAmount = 0;

  // DateTime time = DateTime.now();
  // DateTime today = DateTime.now();
  // DateTime _selectedtime = DateTime.now();
  // String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  // String _endTime = DateFormat("hh:mm a").format(DateTime.now()).toString();

  String courseWeight = "7.5";
  List<String> courseWeightList = [
    "7.5",
    "9",
    "10.5",
  ];

  String courseType = "Core";
  List<String> courseTypeList = [
    "Core",
    "Elective",
  ];

  // String moduleDay = "Mon";
  // List<String> moduleDayList = [
  //   "Mon",
  //   "Tue",
  //   "Wed",
  //   "Thu",
  //   "Fri",
  //   "Sat",
  //   "Sun",
  // ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // String weekd = DateFormat.E().format(today);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppHeader.appBar("Add Courses"),
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
                hint: "Enter Course Name",
                controller: courseName,
              ),
              MyInputField(
                title: "Course Code",
                hint: "Enter Course Code",
                controller: courseCode,
              ),
              MyInputField(
                title: "Lecturer Name",
                hint: "Enter Lecturer Name",
                controller: courseLecturer,
              ),
              MyInputField(
                title: "Course Weight",
                hint: courseWeight,
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
                  items: courseWeightList
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
                      courseWeight = value!;
                    });
                  },
                ),
              ),
              MyInputField(
                title: "Course Type",
                hint: courseType,
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
                  items: courseTypeList
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
                      courseType = value!;
                    });
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () async {
                      int? count = await DbHelper.courseCount(
                          courseCode.text.toUpperCase());

                      if (count! > 0) {
                        List<Modules> regCourse = await DbHelper.retrieveCourse(
                            courseCode.text.toUpperCase());

                        // ignore: use_build_context_synchronously
                        showSnackBar(
                            "Course code is already registered as ${regCourse[0].courseName}!",
                            context,
                            "error");
                      } else {
                        if (courseCount != courseAmount) {
                          _validateData();
                        } else {
                          _validateData();
                          setState(() {
                            courseAmount = 0;
                            courseCount = 1;
                          });

                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BottomNavigation()),
                          );
                        }
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

  _validateData() {
    if (courseName.text.isNotEmpty &&
        courseCode.text.isNotEmpty &&
        courseLecturer.text.isNotEmpty) {
      if (courseAmount == 0) {
        showSnackBar("Click Button on the Top", context, "Warning");
      } else {
        _addModuletoDb();
        setState(() {
          courseCount++;
        });
        clearInputs();
      }
    } else {
      showSnackBar("Form is Not Complete", context, "Warning");
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
    int value = await moduleController.addModule(
      modules1: Modules(
        courseName: courseName.text,
        courseCode: courseCode.text.toUpperCase(),
        courseType: courseType,
        courseLecturer: courseLecturer.text,
        courseWeight: courseWeight,
      ),
    );

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
    } else {
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
    }
  }

  clearInputs() {
    courseName.clear();
    courseCode.clear();
    courseLecturer.clear();
  }
}
