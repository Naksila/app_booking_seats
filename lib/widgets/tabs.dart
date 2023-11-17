// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

class Tabs extends StatelessWidget {
  const Tabs({super.key, this.title, this.onPressed});

  final String? title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Text(
          // ignore: unnecessary_brace_in_string_interps
          '${title}',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        InkWell(
          child: Icon(
            Icons.close,
            size: 20,
            color: Colors.white,
          ),
          onTap: onPressed,
        ),
      ]),
    );
  }
}
