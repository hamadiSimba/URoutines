// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uroutines/model/assignments.dart';
import 'package:uroutines/widgets/appbar.dart';
import 'package:uroutines/widgets/inputField.dart';
import '../controller/assignmentController.dart';
import '../model/modules.dart';
import '../utility/db.dart';
import '../utility/snackbar.dart';
import '../widgets/bottomNavigation.dart';

class AddAssignments extends StatefulWidget {
  const AddAssignments({super.key});

  @override
  State<AddAssignments> createState() => _AddAssignmentsState();
}

class _AddAssignmentsState extends State<AddAssignments> {
  final AssignementController _assignmentController =
      Get.put(AssignementController());
  final TextEditingController question = TextEditingController();
  DateTime dueDate = DateTime.now();

  String courseName = "Courses";
  List<String> courseNameList = [];
  List<String> courseCodeList = [];

  @override
  void initState() {
    refreshModules();
    super.initState();
  }

  String assignmentType = "Individual";

  List<String> assignmentTypeList = [
    "Individual",
    "Group",
  ];

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

  getDateFromUser() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null) {
      setState(() {
        dueDate = picked;
      });
    } else {
      print("Nothng!!!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppHeader.appBar("Add Assignments"),
      body: Container(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.01,
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
                title: "Nature of Work",
                hint: assignmentType,
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
                  items: assignmentTypeList
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
                      assignmentType = value!;
                    });
                  },
                ),
              ),
              MyInputField(
                title: "Due Date",
                hint:
                    "${dueDate.year}-${zeroNumber(dueDate.month)}-${zeroNumber(dueDate.day)}",
                widget: IconButton(
                  onPressed: () {
                    getDateFromUser();
                  },
                  icon: const Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                "Question(s)",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 12.0),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: question,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                    letterSpacing: 1.0,
                  ),
                  decoration: InputDecoration(
                    helperText:
                        "This Question Will be Displayed on Your Cover Page!",
                    helperStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.background,
                        width: 0,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.background,
                        width: 0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      _addAssignmentToDb();
                      print(question.text);
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
                          "Submit",
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

  _addAssignmentToDb() async {
    if (courseName == "Courses") {
      showSnackBar("Please select Course!", context, "Warning");
    } else if (question.text.isNotEmpty) {
      int value = await _assignmentController.addAssignment(
        works: Assignments(
          courseCode: courseCodeList[checkCode(courseName)],
          dueDate:
              "${dueDate.year}-${zeroNumber(dueDate.month)}-${zeroNumber(dueDate.day)} 00:00",
          assignmentType: assignmentType,
          question: question.text,
        ),
      );

      if (value > 0) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const BottomNavigation()));
        showSnackBar("Assignment successfuly Added!", context, "ok");
      } else {
        showSnackBar("Error Inserting Assignment!", context, "Warning");
      }
    } else {
      showSnackBar("Question is not set!", context, "Warning");
    }
  }

  String zeroNumber(int num) {
    if (num < 10) {
      return "0$num";
    } else {
      return "$num";
    }
  }
}
