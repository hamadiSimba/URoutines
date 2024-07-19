import 'package:flutter/material.dart';
import 'dayText.dart';
import 'roundedDay.dart';

class DateColumn extends StatefulWidget {
  const DateColumn({super.key});

  @override
  State<DateColumn> createState() => _DateColumnState();
}

class _DateColumnState extends State<DateColumn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.11,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DayText(dayText: "S"),
                const SizedBox(height: 4.0,),
                RoundedDay(day: "1"),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DayText(dayText: "M", isToday: true,),
                const SizedBox(height: 4.0,),
                RoundedDay(day: "2", isToday: true,),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DayText(dayText: "T"),
                const SizedBox(height: 4.0,),
                RoundedDay(day: "3"),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DayText(dayText: "W"),
                const SizedBox(height: 4.0,),
                RoundedDay(day: "4"),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DayText(dayText: "T"),
                const SizedBox(height: 4.0,),
                RoundedDay(day: "5"),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DayText(dayText: "F"),
                const SizedBox(height: 4.0,),
                RoundedDay(day: "6"),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DayText(dayText: "S"),
                const SizedBox(height: 4.0,),
                RoundedDay(day: "7"),
              ],
            ),
            ],
          ),
          
          const Spacer(),
          const Text(
              "February",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
        ],
      ),
    );
  }
}


