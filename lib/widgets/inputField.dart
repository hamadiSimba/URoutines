import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final Widget? widget;
  final TextEditingController? controller;
  final bool isNumber;
  const MyInputField(
      {super.key,
      required this.title,
      required this.hint,
      this.controller,
      this.widget,
      this.isNumber = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          Container(
            height: 52.0,
            padding: const EdgeInsets.only(left: 14.0),
            margin: const EdgeInsets.only(top: 8.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget == null ? false : true,
                    autofocus: false,
                    keyboardType: isNumber
                        ? TextInputType.phone
                        : TextInputType.emailAddress,
                    cursorColor: Colors.white,
                    controller: controller,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: const TextStyle(color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.background,
                          width: 0,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.background,
                          width: 0,
                        ),
                      ),
                    ),
                  ),
                ),
                widget == null
                    ? Container()
                    : Container(
                        child: widget,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
