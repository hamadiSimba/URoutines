import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uroutines/constants.dart';
import 'package:uroutines/model/alert.dart';
import 'package:uroutines/widgets/countDown.dart';

class RecentsAlerts extends StatefulWidget {
  const RecentsAlerts({super.key});

  @override
  State<RecentsAlerts> createState() => _RecentsAlertsState();
}

class _RecentsAlertsState extends State<RecentsAlerts> {
  DateFormat dateFormat = DateFormat("hh:mm a");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: recentsAlerts.length,
      itemBuilder: (context, int index) {
        Alert alert = recentsAlerts[index];
        int hoursLeft = DateTime.now().difference(alert.time).inHours;
        hoursLeft = hoursLeft < 0 ? hoursLeft * -1 : 0;
        double percent = hoursLeft / 24;
        return FittedBox(
          child: Row(
            children: [
              Container(
                height: size.height * 0.15,
                width: 15.0,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 3.0,
                        spreadRadius: 0.5,
                        offset: Offset(-1, 0),
                      ),
                    ]),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 10.0),
                height: size.height * 0.15,
                width: 300.0,
                decoration: const BoxDecoration(
                    color: kCardColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 3.0,
                        spreadRadius: 0.5,
                        offset: Offset(1, 0),
                      ),
                    ]),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        FittedBox(
                            child: Text(
                          alert.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        )),
                        const SizedBox(
                          height: 8.0,
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
                              "${DateTime.now().weekday == alert.time.weekday ? "Today" : DateFormat.EEEE().format(alert.time)}, ${dateFormat.format(alert.time)}",
                              style: const TextStyle(
                                color: kTextColor,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.receipt,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 18.0,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              alert.subject,
                              style: const TextStyle(
                                color: kTextColor,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      right: 20.0,
                      child: CustomPaint(
                        foregroundPainter: CountDownPainter(
                          bgColor: kBgColor,
                          lineColor: _getColor(context, percent),
                          percent: percent,
                          width: 4.0,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                "$hoursLeft",
                                style: TextStyle(
                                  color: _getColor(context, percent),
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "hours Left",
                                style: TextStyle(
                                  color: _getColor(context, percent),
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
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
}
