import 'package:flutter/material.dart';

class CardColumn extends StatelessWidget {
  final String count;
  final String title;
  final onTap;

  const CardColumn({
    super.key,
    required this.count,
    required this.title,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(count, style:const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22.0,),),
        Text(title, style:const TextStyle(color: Colors.white,  fontSize: 14.0,),),
        const SizedBox(height: 8.0,),
        GestureDetector(onTap: onTap, child: const Text("View",style: TextStyle(color: Colors.white, fontSize: 12.0,))),
      ],
    );
  }
}