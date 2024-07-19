import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Icon(CupertinoIcons.alarm,size: 50.0,color: Colors.white,),
          Text(
            "uRoutines",
            style: TextStyle(
              color: Colors.white,
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
