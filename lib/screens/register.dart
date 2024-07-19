import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:uroutines/controller/userController.dart';
import 'package:uroutines/model/user.dart';
import 'package:uroutines/widgets/appbar.dart';
import 'package:uroutines/widgets/inputField.dart';

import '../utility/snackbar.dart';
import 'addModulesScreen.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  UserDetailsController _userDetailsController =
      Get.put(UserDetailsController());
  TextEditingController fullName = TextEditingController();
  TextEditingController regNumber = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  bool isOther = false;

  int academicYear = 1;
  List<int> academicYearList = [
    1,
    2,
    3,
    4,
  ];

  String gender = "Male";
  List<String> genderList = ["Male", "Female"];

  String institute = "UDOM";
  List<String> instituteList = ["UDOM", "UDSM (Not Yet Implemented)"];

  String college = "CIVE";
  List<String> collegeList = [
    "CIVE",
    "CNMS",
    "COBE",
    "COED",
  ];

  String program = "BSc CS";
  List<String> programList = [
    "BSc CS",
    "BSc CNISE",
    "BSc CE",
    "BSc SE",
    "BSc CSDFE",
    "DCSDF",
    "Other",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppHeader.appBar("Registration"),
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
                title: "Full Name",
                hint: "Enter Your Full Name as Your registration",
                controller: fullName,
              ),
              MyInputField(
                title: "Registration",
                hint: "Example : T21-03-0000",
                controller: regNumber,
              ),
              MyInputField(
                title: "Mobile Phone",
                hint: "Example : 0689000000",
                controller: mobileNo,
                isNumber: true,
              ),
              MyInputField(
                title: "Gender",
                hint: gender,
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
                  items: genderList
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
                      gender = value!;
                    });
                  },
                ),
              ),
              MyInputField(
                title: "Academic Year",
                hint: "Year $academicYear",
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
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 16.0),
                  items: academicYearList
                      .map<DropdownMenuItem<String>>(
                        (int e) => DropdownMenuItem<String>(
                          value: e.toString(),
                          child: Text(e.toString()),
                        ),
                      )
                      .toList(),
                  onChanged: (String? value) {
                    setState(() {
                      academicYear = int.parse(value!);
                    });
                  },
                ),
              ),
              MyInputField(
                title: "University/Institute Name",
                hint: institute,
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
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 16.0),
                  items: instituteList
                      .map<DropdownMenuItem<String>>(
                        (String e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        ),
                      )
                      .toList(),
                  onChanged: (String? value) {
                    setState(() {
                      institute = value!;
                    });
                  },
                ),
              ),
              MyInputField(
                title: "College Name",
                hint: institute == "UDOM" ? college : "Not implemented!",
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
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 16.0),
                  items: institute == "UDOM"
                      ? collegeList
                          .map<DropdownMenuItem<String>>(
                            (String e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(e),
                            ),
                          )
                          .toList()
                      : ["Not Implemented"]
                          .map<DropdownMenuItem<String>>(
                            (String e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(e),
                            ),
                          )
                          .toList(),
                  onChanged: (String? value) {
                    setState(() {
                      college = value!;
                    });
                  },
                ),
              ),
              college == "CIVE"
                  ? MyInputField(
                      title: "Course Program",
                      hint: college == "CIVE" ? program : "Not Implemented!",
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
                        style: const TextStyle(
                            color: Colors.white, fontSize: 16.0),
                        items: programList
                            .map<DropdownMenuItem<String>>(
                              (String e) => DropdownMenuItem<String>(
                                value: e,
                                child: Text(
                                  e,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (String? value) {
                          setState(() {
                            program = value!;
                            if (program == "Other") {
                              isOther = true;
                            } else {
                              isOther = false;
                            }
                          });
                        },
                      ),
                    )
                  : Container(),
              isOther
                  ? MyInputField(
                      title: "Other Course Program",
                      hint: "Example....Bsc course")
                  : Container(),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      _addUserToDb();
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

  _addUserToDb() async {
    if (fullName.text.isNotEmpty &&
        regNumber.text.isNotEmpty &&
        mobileNo.text.isNotEmpty) {
      int value = await _userDetailsController.addUser(
          userDetails: UserDetails(
              fullName: fullName.text.toUpperCase(),
              regNumber: regNumber.text.toUpperCase(),
              mobileNo: mobileNo.text,
              gender: gender,
              program: program,
              academicYear: academicYear,
              college: college,
              institute: institute));
      showSnackBar("User registered Sucessfully", context, "ok");
      fullName.clear;
      regNumber.clear;
      mobileNo.clear;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AddModules()),
      );
      print("User Entered id is $value");
    } else {
      showSnackBar(
          "There is an Error in User registration", context, "warning");
    }
  }
}
