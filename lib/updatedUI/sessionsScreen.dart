import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:uroutines/updatedUI/widgets/dateColumn.dart';
import 'package:uroutines/updatedUI/widgets/header.dart';
import 'package:uroutines/updatedUI/widgets/space.dart';

import 'widgets/infoWidget.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  String info =
      "A computer is a data processing machine. It does nothing until a user (or a script or a  program) provides the data that needs to be processed and the instructions that tell it how to process the data.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 1,
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Header(dayTitle: "Today"),
              const Space(),
              DateColumn(),
              const Space(),
              Information(
                info: info,
              ),
              SessionsWidget(),
              Separator(),
              SessionCard(
                isActive: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SessionsWidget extends StatefulWidget {
  const SessionsWidget({super.key});

  @override
  State<SessionsWidget> createState() => _SessionsWidgetState();
}

class _SessionsWidgetState extends State<SessionsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      width: MediaQuery.of(context).size.width * 1,
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (context, index) {
            return SessionCard(
              isActive: true,
            );
          }),
    );
  }
}

class SessionCard extends StatelessWidget {
  final bool isActive;
  const SessionCard({this.isActive = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.09,
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                SessionTime(
                  time: "12:00",
                  isActive: true,
                ),
                SessionTime(
                  time: "14:00",
                  isActive: true,
                )
              ],
            ),
          ),
          const SizedBox(
            width: 4.0,
          ),
          Container(
            width: 2.0,
            height: MediaQuery.of(context).size.height * 0.09,
            color: isActive ? Colors.white : Colors.white54,
          ),
          const SizedBox(
            width: 6.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.08,
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              top: 8.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: isActive ? Colors.white : Colors.white54,
            ),
            child: Column(
              children: [
                Text(
                  "Computer Design And Architecture",
                  style: TextStyle(
                    color: isActive ? Colors.black : Colors.black54,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    fontSize: 16.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Dr. Mohammed Mjahidi",
                      style: TextStyle(
                        color: isActive ? Colors.black : Colors.black54,
                        fontWeight: FontWeight.normal,
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      "LRB 105",
                      style: TextStyle(
                        color: isActive ? Colors.black : Colors.black54,
                        fontWeight: FontWeight.normal,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
                const Space(),
                Container(
                  width: 80.0,
                  height: 18,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "CP 226",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: isActive ? Colors.white : Colors.white54,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
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
  }
}

class SessionTime extends StatelessWidget {
  final String time;
  final bool isActive;
  const SessionTime({required this.time, this.isActive = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      time,
      style: TextStyle(
        color: isActive ? Colors.white : Colors.white54,
        fontSize: 12.0,
      ),
    );
  }
}

class Separator extends StatelessWidget {
  const Separator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "///////////////////////////EXTRA TIMETABLE/////////////////////////",
      maxLines: 1,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
      ),
    );
  }
}
