import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uroutines/constants.dart';
import 'package:flutter/material.dart';
import 'package:uroutines/model/sessions.dart';
import 'package:uroutines/services/notification.dart';
import 'package:uroutines/utility/db.dart';
import '../main.dart';

class BuildClasses extends StatefulWidget {
  BuildClasses({super.key});

  @override
  State<BuildClasses> createState() => _BuildClassesState();
}

class _BuildClassesState extends State<BuildClasses> {
  DateFormat dateFormat = DateFormat("hh:mm a");
  int modLength = 0;
  DateTime fixedtoday = DateTime.now();
  final _notifyHelper = Get.put(NotifyHelper());
  Timer? _timer;
  Timer? _heightTimer;
  double changingHeight = 0;
  List<Sessions> allModules = [];
  int dayList = 0;
  int counter = 0;

  @override
  void initState() {
    super.initState();
    refreshModules();
    updateTime();
  }

  @override
  void dispose() {
    super.dispose();

    try {
      _timer!.cancel();
      _heightTimer!.cancel();
    } catch (e) {
      print("Heigth Timer");
    }
  }

  updateTime() async {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        today = DateTime.now();
      });
    });
  }

  refreshModules() async {
    List<Sessions> x =
        await DbHelper.sessionsQuery(DateFormat.E().format(today));
    setState(() {
      dayList = today.day;
      allModules = x;
    });
  }

  dateRefreshModules(int selectedDay, DateTime entDay) async {
    List<Sessions> x =
        await DbHelper.sessionsQuery(DateFormat.E().format(entDay));
    setState(() {
      dayList = selectedDay;
      allModules = x;
    });
  }

  String changeDate(int num) {
    if (num > 9) {
      return "$num";
    } else {
      return "0$num";
    }
  }

  dialog(BuildContext context, int id) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Are You sure!"),
          content: const Text("You want to Delete?"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("No")),
            TextButton(
                onPressed: () {
                  DbHelper.deleteSession(id);
                  refreshModules();
                  FlutterBackgroundService().invoke("refreshSession");
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
    return allModules.length != 0
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: allModules.length,
            itemBuilder: (context, index) {
              Sessions c = allModules[index];
              _getStatus(c);

              // DateTime.parse("${DateTime.now().year}-${changeDate(DateTime.now().month)}-${changeDate(DateTime.now().day)} ${twelveTotwentyFour(_startTime)}"),
              if (fixedtoday
                      .difference(DateTime.parse(
                          "${DateTime.now().year}-${changeDate(DateTime.now().month)}-${changeDate(dayList)} ${c.startTime!}"))
                      .inMinutes ==
                  0) {
                if (counter == 0) {
                  _notifyHelper.showNotification(
                      title: "Session (by ${c.courseLecturer}):",
                      body: "${c.courseName} (${c.courseCode}) is started!");
                  counter++;
                }
              }

              //Changing Height.

              // ignore: unnecessary_null_comparison
              return GestureDetector(
                onLongPress: () {
                  dialog(context, c.id!);
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          dateFormat.format(DateTime.parse(
                              "${DateTime.now().year}-${changeDate(DateTime.now().month)}-${changeDate(dayList)} ${c.startTime!}")),
                          style: TextStyle(
                            color: c.isPassed
                                ? Colors.white.withOpacity(0.2)
                                : Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        _getTime(c, context),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Column(
                          children: [
                            Text(
                              "${c.courseName}",
                              style: TextStyle(
                                color: c.isPassed
                                    ? Colors.white.withOpacity(0.2)
                                    : Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                              ),
                            ),
                            Text(
                              "(${c.courseCode})",
                              style: TextStyle(
                                color: c.isPassed
                                    ? Colors.white.withOpacity(0.2)
                                    : Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        c.isHappening
                            ? Container(
                                height: 25.0,
                                width: 40.0,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: const Center(
                                    child: Text(
                                  "Now",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                              )
                            : Container(),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        c.isHappening
                            ? Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        bottom: 20.0),
                                    width: 2.0,
                                    height: 100.0,
                                    color: c.isPassed
                                        ? kTextColor.withOpacity(0.3)
                                        : kTextColor,
                                  ),
                                  c.isPassed
                                      ? Container()
                                      : Container(
                                          margin: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
                                              bottom: 20.0),
                                          width: 4.0,
                                          height:
                                              changingHeight, //Height should increase as hours increase.
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                ],
                              )
                            : Container(
                                margin: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width * 0.2,
                                    bottom: 20.0),
                                width: 2.0,
                                height: 100.0,
                                color: c.isPassed
                                    ? kTextColor.withOpacity(0.3)
                                    : kTextColor,
                              ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 20.0,
                                  color: c.isPassed
                                      ? Theme.of(context)
                                          .colorScheme
                                          .secondary
                                          .withOpacity(0.3)
                                      : Theme.of(context).colorScheme.secondary,
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  c.sessionType!,
                                  style: TextStyle(
                                    color: c.isPassed
                                        ? kTextColor.withOpacity(0.2)
                                        : kTextColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6.0,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.house_siding,
                                  size: 20.0,
                                  color: c.isPassed
                                      ? Theme.of(context)
                                          .colorScheme
                                          .secondary
                                          .withOpacity(0.3)
                                      : Theme.of(context).colorScheme.secondary,
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  c.venue!,
                                  style: TextStyle(
                                    color: c.isPassed
                                        ? kTextColor.withOpacity(0.2)
                                        : kTextColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6.0,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 20.0,
                                  color: c.isPassed
                                      ? Theme.of(context)
                                          .colorScheme
                                          .secondary
                                          .withOpacity(0.3)
                                      : Theme.of(context).colorScheme.secondary,
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  c.courseLecturer!,
                                  style: TextStyle(
                                    color: c.isPassed
                                        ? kTextColor.withOpacity(0.2)
                                        : kTextColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6.0,
                            ),
                            Text(
                              "${_getPeriod(c)}",
                              style: TextStyle(
                                color: c.isPassed
                                    ? kTextColor.withOpacity(0.2)
                                    : kTextColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.book_fill,
                size: 52,
                color: Theme.of(context).colorScheme.secondary,
              ),
              Text(
                "No Sessions!",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 18),
              ),
            ],
          );
  }

  _getStatus(Sessions c) {
    DateTime end = getSessionTypeSession(c.sessionType!, c.startTime!);

    if (c.sessionType == "Lecture" || c.sessionType == "Practical") {
      if (today
              .difference(DateTime.parse(
                  "${DateTime.now().year}-${changeDate(DateTime.now().month)}-${changeDate(dayList)} ${c.startTime!}"))
              .inMinutes >
          119) {
        c.isPassed = true;
      } else if (today
                  .difference(DateTime.parse(
                      "${DateTime.now().year}-${changeDate(DateTime.now().month)}-${changeDate(dayList)} ${c.startTime!}"))
                  .inMinutes <
              120 &&
          today.difference(end).inMinutes >= -120) {
        c.isHappening = true;
      }
    } else {
      if (today
              .difference(DateTime.parse(
                  "${DateTime.now().year}-${changeDate(DateTime.now().month)}-${changeDate(dayList)} ${c.startTime!}"))
              .inMinutes >
          59) {
        c.isPassed = true;
      } else if (today
                  .difference(DateTime.parse(
                      "${DateTime.now().year}-${changeDate(DateTime.now().month)}-${changeDate(dayList)} ${c.startTime!}"))
                  .inMinutes <
              60 &&
          today.difference(end).inMinutes >= -60) {
        c.isHappening = true;
      }
    }
  }

  DateTime getSessionTypeSession(String sesstype, String time) {
    if (sesstype == "Tutorial") {
      return DateTime.parse(
              "${DateTime.now().year}-${changeDate(DateTime.now().month)}-${changeDate(dayList)} ${time}")
          .add(Duration(hours: 1));
    } else {
      return DateTime.parse(
              "${DateTime.now().year}-${changeDate(DateTime.now().month)}-${changeDate(dayList)} ${time}")
          .add(Duration(hours: 2));
    }
  }

  _getTime(Sessions c, BuildContext context) {
    return Container(
      height: 25.0,
      width: 25.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: c.isPassed
              ? Theme.of(context).colorScheme.secondary.withOpacity(0.3)
              : Theme.of(context).colorScheme.secondary,
        ),
      ),
      child: _getChild(c, context),
    );
  }

  _getPeriod(Sessions c) {
    if (c.isPassed) {
      return "Closed";
    } else if (c.isHappening) {
      return "On Going...";
    } else {
      return "Soon";
    }
  }

  _getChild(Sessions c, BuildContext context) {
    if (c.isPassed) {
      return Icon(
        Icons.check,
        color: c.isPassed
            ? Theme.of(context).colorScheme.secondary.withOpacity(0.3)
            : Theme.of(context).colorScheme.secondary,
        size: 15.0,
      );
    } else if (c.isHappening) {
      return Container(
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          shape: BoxShape.circle,
        ),
      );
    }

    return null;
  }
}
