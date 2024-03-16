// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'dart:ffi';

import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  Color color = Colors.blue,
  double radius = 0.0,
  double height = 40,
  bool isUpperCase = true,
  required String text,
  required void Function()? function,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
        color: color, borderRadius: BorderRadius.circular(radius)),
    child: MaterialButton(
      onPressed: function,
      child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}

Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required bool isPrefix,
  bool isSuffix = false,
  bool isPass = false,
  required validate,
  IconData? prefix,
  prefixPressed,
  Color? prefixColor,
  double? prefixIconSize,
  onTap,
  bool isClickable = true,
  // IconData? suffix
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    obscureText: isPass,
    enabled: isClickable,
    onFieldSubmitted: (value) {},
    // onChanged: (value) { },
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      labelText: label,
      prefixIcon: isPrefix
          ? IconButton(
              icon: Icon(
                prefix,
                color: prefixColor ?? Colors.blue,
                size: prefixIconSize ?? 25,
              ),
              onPressed: () {
                prefixPressed();
              },
            )
          : null,
      // suffixIcon: isSuffix?  null:suffix,
    ),
    onTap: onTap,
    validator: validate,
  );
}

double screenWidth(BuildContext context, double value) {
  return MediaQuery.of(context).size.width * value;
}

double screenHeight(BuildContext context, double value) {
  return MediaQuery.of(context).size.height * value;
}

double padding(BuildContext context) {
  return MediaQuery.of(context).size.width * 0.04;
}

Widget buildTaskItem(Map model) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.blue,
          child: Text(
            '${model['title']}',
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${model['time']}',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(
              '${model['date']}',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
