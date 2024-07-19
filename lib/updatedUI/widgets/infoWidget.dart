import 'package:flutter/material.dart';

class Information extends StatelessWidget {
  final String info;
  const Information({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width * 1,
      child: Text(
        info,
        maxLines: 4,
        textAlign: TextAlign.left,
        style:const TextStyle(
          color: Colors.white,
          fontSize: 12.0,
          letterSpacing: 1.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}