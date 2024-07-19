// ignore_for_file: no_logic_in_create_state

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uroutines/constants.dart';
import 'package:uroutines/model/modules.dart';
import 'package:uroutines/screens/register.dart';

import '../model/user.dart';
import '../utility/db.dart';
import '../widgets/bottomNavigation.dart';
import 'addModulesScreen.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({
    super.key,
  });

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    try {
      refreshUsers();
    } catch (e) {
      print("No user!");
    }
    super.initState();
  }

  List<UserDetails> userS = [];
  List<Modules> cozes = [];

  refreshUsers() async {
    List<UserDetails> x = await DbHelper.userQuery();
    List<Modules> dbCozes = await DbHelper.courseQuery();
    setState(() {
      userS = x;
      cozes = dbCozes;
    });
  }

  dialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("There is No any Course!"),
          content: const Text(
              "You Want to proceed or Bring Course registration Screen?"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const AddModules()),
                  );
                },
                child: const Text("Register Courses")),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BottomNavigation()),
                  );
                },
                child: const Text("Proceed")),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (userS.length != 0) {
      if (cozes.length > 0) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const BottomNavigation()),
          );
        });
      } else {
        //Prompt user to Continue or Go to the courses screen.
        dialog(context);
      }
    }
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 100,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0),
                  )),
            ),
            const Positioned(
                top: 200.0,
                left: 100.0,
                right: 100.0,
                child: FittedBox(
                  child: Text(
                    "uRoutines",
                    style: TextStyle(
                      fontSize: 42.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
            Positioned(
                bottom: 170.0,
                left: 50.0,
                right: 50.0,
                child: Column(
                  children: const [
                    Text(
                      "Welcome",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Check your Daily routine when you're in Universisty!!!",
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
            userS.length == 0
                ? Positioned(
                    top: MediaQuery.of(context).size.height - 130,
                    left: 100.0,
                    right: 100.0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Register()),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: 55.0,
                        padding: const EdgeInsets.only(left: 50.0),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(50.0)),
                        child: FittedBox(
                          child: Row(
                            children: const [
                              Text(
                                "GET STARTED",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.white,
                                size: 28.0,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
