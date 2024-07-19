import 'package:flutter/material.dart';

class DayText extends StatelessWidget {
  final String dayText;
  final bool isToday;
  DayText({required this.dayText, this.isToday = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      dayText,
      style: TextStyle(
        fontSize: 14.0,
        color:Colors.white,
        fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}