import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants.dart';
import '../model/assignments.dart';
import '../utility/db.dart';
import 'countDown.dart';

class RecentAssignments extends StatefulWidget {
  const RecentAssignments({super.key});

  @override
  State<RecentAssignments> createState() => _RecentAssignmentsState();
}

class _RecentAssignmentsState extends State<RecentAssignments> {
  DateTime Today = DateTime.now();
  DateFormat dateFormat = DateFormat("hh:mm a");
  List<Assignments> oneAssignment = [];

  @override
  void initState() {
    _fetchAssignent();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _fetchAssignent() async {
    List<Assignments> assignNums = await DbHelper.allAssignmentQuery();
    setState(() {
      oneAssignment = assignNums;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: oneAssignment.length > 0 ? 1 : 0,
      itemBuilder: (context, index) {
        Assignments assignment = oneAssignment[index];

        int hoursLeft = DateTime.now()
            .difference(DateTime.parse(assignment.dueDate!))
            .inHours;
        hoursLeft = hoursLeft < 0 ? hoursLeft * -1 : 0;
        double percent = hoursLeft / 24;
        return FittedBox(
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10.0),
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 10.0, 10.0),
                height: 108.0,
                width: 306.0,
                decoration: BoxDecoration(
                    color: kCardColor,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 3.0,
                        spreadRadius: 0.5,
                        offset: Offset(0, 1),
                      ),
                    ]),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          assignment.courseCode!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0,
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.clock,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 18.0,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              "${DateTime.now().day == DateTime.parse(assignment.dueDate!).day ? DateFormat.yMMMd().format(Today) : DateFormat.yMMMd().format(DateTime.parse(assignment.dueDate!))}, ${dateFormat.format(DateTime.parse(assignment.dueDate!))}",
                              style: const TextStyle(
                                color: kTextColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 28.0),
                          child: Text(
                            DateFormat.EEEE()
                                .format(DateTime.parse(assignment.dueDate!)),
                            style: const TextStyle(
                              color: kTextColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // _todoButton(assignment),
                    Expanded(
                      child: CustomPaint(
                        foregroundPainter: CountDownPainter(
                          bgColor: kBgColor,
                          lineColor: _getColor(context, percent),
                          percent: percent,
                          width: 4.0,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: FittedBox(
                            child: Column(
                              children: [
                                FittedBox(
                                  child: Text(
                                    "$hoursLeft",
                                    style: TextStyle(
                                      color: _getColor(context, percent),
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                FittedBox(
                                  child: Text(
                                    "hours Left",
                                    style: TextStyle(
                                      color: _getColor(context, percent),
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _getColor(BuildContext context, double percent) {
    if (percent >= 0.35) {
      return Theme.of(context).colorScheme.secondary;
    }

    return kHourColor;
  }

  _todoButton(Assignments assignment) {
    return GestureDetector(
      onTap: () {
        setState(() {
          assignment.isDone = assignment.isDone!;
        });
      },
      child: CircleAvatar(
        backgroundColor: Colors.green,
        radius: 22,
        child: CircleAvatar(
          radius: 20.0,
          backgroundColor: assignment.isDone! == 1
              ? Theme.of(context).colorScheme.secondary
              : Color.fromARGB(255, 63, 62, 62),
          child: assignment.isDone! == 1
              ? const Icon(
                  Icons.check,
                  color: Colors.white,
                )
              : null,
        ),
      ),
    );
  }
}
