import 'package:flutter/material.dart';

class RoundedDay extends StatelessWidget {
  final String day;
  final bool isToday;
  const RoundedDay({super.key, required this.day, this.isToday = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.0,
      height: 30.0,
      decoration: BoxDecoration(
        border: Border.all(
          color: isToday ? Colors.white54 : Colors.white,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(50),
        color: isToday ? Colors.white : Colors.black,
      ),
      child: Center(
        child: Text(
          day,
          style: TextStyle(
            color: isToday ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}