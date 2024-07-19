import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class Header extends StatelessWidget {
  String dayTitle;
  Header({required this.dayTitle, super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.05,
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            dayTitle,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 36.0,
            ),
          ),
          Icon(
            CupertinoIcons.book_circle,
            size: 34.0,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
