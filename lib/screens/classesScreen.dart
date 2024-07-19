import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uroutines/constants.dart';
import 'package:uroutines/widgets/header.dart';

// import '../controller/moduleController.dart';
import '../widgets/buildClasses.dart';

class ClassesScreen extends StatefulWidget {
  const ClassesScreen({super.key});

  @override
  State<ClassesScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  DateTime today = DateTime.now();
  Timer? _timer;
  // final _moduleController = Get.put(ModuleController());

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer!.cancel();
  }

  void _updateTime() {
    setState(() {
      today = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedDay = DateFormat.LLL().format(today);
    String weekd = DateFormat.E().format(today);
    //  _moduleController.getModules(weekd);
    print(formattedDay);
    return ListView(
      children: [
        const Header(),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            30.0,
            10.0,
            30.0,
            30.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${formattedDay}, ${today.year}",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    today.day - 3 > 9
                        ? "${today.day - 3}"
                        : "0${today.day - 3}",
                    style: kCalenderDay,
                  ),
                  Text(
                    today.day - 2 > 9
                        ? "${today.day - 2}"
                        : "0${today.day - 2}",
                    style: kCalenderDay,
                  ),
                  Text(
                    today.day - 1 > 9
                        ? "${today.day - 1}"
                        : "0${today.day - 1}",
                    style: kCalenderDay,
                  ),
                  Text(
                    today.day > 9 ? "${today.day}" : "0${today.day}",
                    style: kCalenderDay.copyWith(
                      color: Colors.white,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    today.day + 1 > 9
                        ? "${today.day + 1}"
                        : "0${today.day + 1}",
                    style: kCalenderDay,
                  ),
                  Text(
                    today.day + 2 > 9
                        ? "${today.day + 2}"
                        : "0${today.day + 2}",
                    style: kCalenderDay,
                  ),
                  Text(
                    today.day + 3 > 9
                        ? "${today.day + 3}"
                        : "0${today.day + 3}",
                    style: kCalenderDay,
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 3.0,
                  ),
                  child: Text(
                    weekd,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 17.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
              left: 22.0, right: 10.0, bottom: 35.0, top: 35.0),
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50.0),
              topRight: Radius.circular(50.0),
            ),
          ),
          child: BuildClasses(),
        ),
      ],
    );
  }
}
