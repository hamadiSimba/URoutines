import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uroutines/model/modules.dart';
import 'package:uroutines/utility/db.dart';
import '../constants.dart';
import '../model/user.dart';
import 'editCourse.dart';

class RegisteredCourses extends StatefulWidget {
  const RegisteredCourses({super.key});

  @override
  State<RegisteredCourses> createState() => _RegisteredCoursesState();
}

class _RegisteredCoursesState extends State<RegisteredCourses> {
  List<Modules> allCourses = [];
  List<UserDetails> userDet = [];
  bool isStart = true;

  @override
  void initState() {
    super.initState();
    retreeve();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isStart = false;
      });
    });
  }

  retreeve() async {
    List<Modules> allCoursesQuery = await DbHelper.courseQuery();
    List<UserDetails> user = await DbHelper.userQuery();
    setState(() {
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
                const Text(
                  "All Registered Courses",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${userDet.isNotEmpty ? userDet[0].program : "Bsc"} ${userDet.isNotEmpty ? userDet[0].academicYear : "0"},",
                              style: TextStyle(
                                  color: Colors.grey.shade400, fontSize: 14.0),
                            ),
                            SizedBox(
                              width: size.width * 0.01,
                            ),
                            Text(
                              "${userDet.isNotEmpty ? userDet[0].college : "Coll"}",
                              style: TextStyle(
                                  color: Colors.grey.shade400, fontSize: 14.0),
                            ),
                            SizedBox(
                              width: size.width * 0.01,
                            ),
                            Icon(
                              CupertinoIcons.arrow_right,
                              color: Colors.grey.shade400,
                              size: 20,
                            ),
                            SizedBox(
                              width: size.width * 0.01,
                            ),
                            Text(
                              "${userDet.isNotEmpty ? userDet[0].institute : "Inst"}",
                              style: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
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
                      "${allCourses.length} Found",
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
                    itemCount: allCourses.length,
                    itemBuilder: (context, index) {
                      Modules course = allCourses[index];
                      return Container(
                        height: size.height * 0.19,
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration:
                            const BoxDecoration(color: kCardColor, boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 3.0,
                            spreadRadius: 0.5,
                            offset: Offset(1, 0),
                          ),
                        ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.book,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 4.0,
                                    ),
                                    FittedBox(
                                      child: Text(
                                        "${course.courseName}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: size.height * 0.04,
                                  width: size.width * 0.3,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      borderRadius: BorderRadius.circular(14)),
                                  child: Center(
                                    child: Text(
                                      "${course.courseType}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 2.5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.008),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                      "${course.courseCode}",
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
                                      "Course Weight",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.002),
                                    Text(
                                      "${course.courseWeight}",
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
                                      "Sessions in Week",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.002),
                                    Text(
                                      "2",
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
                                      "Assignments",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.002),
                                    Text(
                                      "6",
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    dialog(context, course.id!,
                                        course.courseName!, course.courseCode!);
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
                                            CupertinoIcons.bin_xmark_fill,
                                            color: Colors.blue,
                                            size: 15.0,
                                          ),
                                          SizedBox(
                                            width: 4.0,
                                          ),
                                          Text(
                                            "Delete",
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => UpdateCourse(
                                                  cid: course.id!,
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
                                      child: Text(
                                        "View Assignments",
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.008),
                            Center(
                              child: Container(
                                height: size.height * 0.03,
                                width: size.width * 0.5,
                                padding: const EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    )),
                                child: FittedBox(
                                  child: Text(
                                    "By ${course.courseLecturer}",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.5),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 6.0,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.08,
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
