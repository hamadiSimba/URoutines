import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uroutines/model/modules.dart';
import 'package:uroutines/utility/db.dart';
import '../constants.dart';
import '../model/allAssignments.dart';
import '../model/user.dart';
import 'editCourse.dart';

class AllAssignment extends StatefulWidget {
  const AllAssignment({super.key});

  @override
  State<AllAssignment> createState() => _AllAssignmentState();
}

class _AllAssignmentState extends State<AllAssignment> {
  DateTime Today = DateTime.now();
  DateFormat dateFormat = DateFormat("hh:mm a");
  List<AssignmentsDetails> allAssignment = [];
  List<Modules> allCourses = [];
  List<UserDetails> userDet = [];
  Timer? _timer;
  bool isStart = true;
  bool isStarts = true;

  @override
  void initState() {
    super.initState();
    retreeve();
    updateTime();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isStart = false;
      });
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        isStarts = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    try {
      _timer!.cancel();
    } catch (e) {
      print("Heigth Timer");
    }
  }

  updateTime() async {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        Today = DateTime.now();
      });
    });
  }

  retreeve() async {
    List<Modules> allCoursesQuery = await DbHelper.courseQuery();
    List<UserDetails> user = await DbHelper.userQuery();
    List<AssignmentsDetails> assignNums = await DbHelper.assignmentDetQuery();

    setState(() {
      allAssignment = assignNums;
      allCourses = allCoursesQuery;
      userDet = user;
    });
  }

  dialog(BuildContext context, int id, String somo, String code) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Are You sure!"),
          content: Text("You want to Delete $somo($code)?"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("No")),
            TextButton(
                onPressed: () {
                  DbHelper.deleteModule(id);
                  retreeve();
                  Navigator.pop(context);
                },
                child: const Text("Yes")),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFF202328),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color(0xFF63CF93))
            .copyWith(background: const Color(0xFF12171D)),
      ),
      home: Scaffold(
        body: SafeArea(
          child: Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.001),
                  height: size.height * 0.055,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          splashColor: Colors.blue,
                          hoverColor: Colors.blue,
                          icon: Icon(
                            CupertinoIcons.left_chevron,
                            // size: 30,
                            color: Colors.grey.shade400,
                          )),
                      Expanded(
                        child: Center(
                          child: Text(
                            "All Assignments",
                            style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            retreeve();
                          },
                          icon: Icon(
                            CupertinoIcons.refresh,
                            size: 30,
                            color: Colors.grey.shade400,
                          )),
                    ],
                  ),
                ),
                AnimatedContainer(
                  curve: Curves.bounceOut,
                  duration: const Duration(seconds: 1),
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  height: isStart == true ? size.height * 0.055 : 0,
                  color: Colors.white24,
                  child: Center(
                    child: Text(
                      "${allAssignment.length} Found",
                      style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: allAssignment.length,
                    itemBuilder: (context, index) {
                      AssignmentsDetails assigment = allAssignment[index];

                      int allMins =
                          Today.difference(DateTime.parse(assigment.dueDate!))
                                  .inMinutes *
                              -1;

                      int daysLeft = allMins ~/ 1440;
                      int hourLeft = (allMins % 1440) ~/ 60;
                      int minsLeft = (allMins % 1440) % 60;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.linear,
                        height: isStarts == true ? 0 : size.height * 0.23,
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        margin: const EdgeInsets.only(top: 6.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: daysLeft > 2
                                ? Colors.grey
                                : daysLeft == 2
                                    ? Color(0xFFF5C35A)
                                    : Colors.red,
                          ),
                          color: kCardColor,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 3.0,
                              spreadRadius: 0.5,
                              offset: Offset(1, 0),
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.device_laptop,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 4.0,
                                      ),
                                      FittedBox(
                                        child: Text(
                                          "${assigment.courseName}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 6.0),
                                    height: size.height * 0.06,
                                    width: size.width * 0.3,
                                    decoration: BoxDecoration(
                                        color: daysLeft > 2
                                            ? Theme.of(context)
                                                .colorScheme
                                                .secondary
                                            : daysLeft == 2
                                                ? Color(0xFFF5C35A)
                                                : Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(14)),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${daysLeft < 0 ? "0" : "$daysLeft"} Days",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 2.5),
                                          ),
                                          Text(
                                            "${hourLeft < 0 ? "0" : "$hourLeft"} Hours",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 2.5),
                                          ),
                                          Text(
                                            "$minsLeft Mins",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0,
                                                letterSpacing: 2.5),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * 0.008),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Course Code",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.002),
                                      Text(
                                        "${assigment.courseCode}",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 1.0,
                                    height: size.height * 0.025,
                                    color: Colors.grey,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Nature Of Work",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.002),
                                      Text(
                                        "${assigment.assignmentType}",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 1.0,
                                    height: size.height * 0.025,
                                    color: Colors.grey,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Submission Date",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.002),
                                      Text(
                                        "${DateTime.now().day == DateTime.parse(assigment.dueDate!).day ? DateFormat.yMMMd().format(Today) : DateFormat.yMMMd().format(DateTime.parse(assigment.dueDate!))}, ${dateFormat.format(DateTime.parse(assigment.dueDate!))}",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                height: 1.0,
                                color: Theme.of(context).colorScheme.secondary,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateCourse(
                                                    cid: assigment.id!,
                                                  )));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      height: size.height * 0.035,
                                      width: size.width * 0.21,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.blue),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Center(
                                        child: Row(
                                          children: [
                                            Icon(
                                              CupertinoIcons.pencil,
                                              color: Colors.blue,
                                              size: 15.0,
                                            ),
                                            SizedBox(
                                              width: 4.0,
                                            ),
                                            Text(
                                              "Edit",
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    DateFormat.EEEE().format(
                                        DateTime.parse(assigment.dueDate!)),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * 0.01),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      height: size.height * 0.035,
                                      width: size.width * 0.4,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.blue),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              CupertinoIcons.eye,
                                              color: Colors.blue,
                                              size: 16.0,
                                            ),
                                            SizedBox(
                                              width: 4.0,
                                            ),
                                            Text(
                                              "View Question (s)",
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print(minsLeft);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      height: size.height * 0.035,
                                      width: size.width * 0.4,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.blue),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              CupertinoIcons.printer_fill,
                                              color: Colors.blue,
                                              size: 16.0,
                                            ),
                                            SizedBox(
                                              width: 4.0,
                                            ),
                                            Text(
                                              "Generate Cover",
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<int> sessCounts(String code) async {
    int sessionCount = 0;
    int? sessions = await DbHelper.sessionCount(code);

    setState(() {
      sessionCount = sessions!;
    });

    return sessionCount;
  }

  Future<int> assignCounts(String code) async {
    int? assignment = await DbHelper.assignmentCount(code);
    int assignmentCount = 0;

    setState(() {
      assignmentCount = assignment!;
    });
    return assignmentCount;
  }
}
