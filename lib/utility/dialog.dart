// import 'package:flutter/material.dart';

//  dialog(BuildContext context, Widget widget, String title){
//     return showDialog(context: context, builder:(context) {
//       return AlertDialog(
//         title: Text(
//           title,
//           style: TextStyle(
//             fontSize: 16.0,
//             fontWeight: FontWeight.bold,
//             color: Theme.of(context).accentColor,
//         ),),
//         content : Container(
//           height: 52.0,
//             padding:const EdgeInsets.only(left: 14.0),
//             margin:const EdgeInsets.only(top: 8.0),
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: Theme.of(context).accentColor,
//                 width: 1.0,
//               ),
//               borderRadius: BorderRadius.circular(12),
//             ),
//           child: widget,
//         ),
//         actions: [
//           TextButton(onPressed: (){
//             setState(() {
//               courseAmount = int.parse(courses.text);
//             });
//             Navigator.pop(context);
//           }, child: Text("Ok",style: TextStyle(
//             fontSize: 14.0,
//             color: Theme.of(context).accentColor,
//           ),)),
//         ],
//       );
//     },);
//   }