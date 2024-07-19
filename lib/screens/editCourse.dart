import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uroutines/controller/moduleController.dart';
import 'package:uroutines/model/modules.dart';
import 'package:uroutines/screens/registeredCourses.dart';
import 'package:uroutines/utility/db.dart';
import 'package:uroutines/widgets/appbar.dart';
import 'package:uroutines/widgets/inputField.dart';

import '../utility/snackbar.dart';

class UpdateCourse extends StatefulWidget {
  final int cid;
  const UpdateCourse({super.key, required this.cid});

  @override
  State<UpdateCourse> createState() => _UpdateCourseState(parsedData: cid);
}

class _UpdateCourseState extends State<UpdateCourse> {
  ModuleController moduleController = Get.put(ModuleController());
  final TextEditingController courseName = TextEditingController();
  final TextEditingController courseCode = TextEditingController();
  final TextEditingController courseLecturer = TextEditingController();
  final TextEditingController courses = TextEditingController();
  int parsedData;

  _UpdateCourseState({required this.parsedData});
  fetchCourse() async {
    List<Modules> xCourse = await DbHelper.singleCourseQuery(parsedData);
    setState(() {
      courseName.text = xCourse[0].courseName!;
      courseCode.text = xCourse[0].courseCode!;
      courseLecturer.text = xCourse[0].courseLecturer!;
      courseWeight = xCourse[0].courseWeight!;
      courseType = xCourse[0].courseType!;
    });
  }

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

  @override
  void initState() {
    super.initState();
    fetchCourse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppHeader.appBar("Edit Course"),
      body: Container(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.05,
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
                      _validateData();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisteredCourses()));
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
                          "Update",
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
      _updateModuletoDb(parsedData);
      showSnackBar("Course Updated Sucessfully!", context, "ok");
      clearInputs();
    } else {
      showSnackBar("Form is Not Complete", context, "Warning");
    }
  }

  _updateModuletoDb(int id) async {
    // ignore: unused_local_variable
    int value = await moduleController.updateModule(
      modules1: Modules(
        courseName: courseName.text,
        courseCode: courseCode.text.toUpperCase(),
        courseType: courseType,
        courseLecturer: courseLecturer.text,
        courseWeight: courseWeight,
      ),
      id: id,
    );
  }

  clearInputs() {
    courseName.clear();
    courseCode.clear();
    courseLecturer.clear();
  }
}
