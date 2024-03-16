// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app/shared/components/components.dart';
import 'package:app/shared/components/constants.dart';
import 'package:flutter/material.dart';

class NewTasksScreen extends StatelessWidget {
  const NewTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return buildTaskItem(tasks[index]);
        },
        separatorBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsetsDirectional.only(start: 20),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[200],
            ),
          );
        },
        itemCount: tasks.length);
  }
}
//tasks.length