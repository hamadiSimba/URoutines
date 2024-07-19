
import 'package:flutter/material.dart';

class AppHeader{
  static appBar(String title){
    return AppBar(
      backgroundColor:const Color(0xFF63CF93),
      title: Center(child: Text(title, style:const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),)),
      // leading: GestureDetector(
      //   onTap: () {
          
      //   },
      //   child:const Icon(
      //     Icons.alarm,
      //     size: 20,
      //   ),
      // ),
      // actions:const [
      //   Icon(Icons.person, size: 20,),
      // //   SizedBox(width: 20,),
      // ],
    );
  }
}