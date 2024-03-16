// ignore_for_file: prefer_const_constructors, unused_import

import 'package:app/layout/home_layout.dart';
import 'package:app/layout/modules/bmi_screen/bmi_csreen.dart';
import 'package:app/layout/modules/bmi_results/bmi_result.dart';
import 'package:app/layout/modules/counter/counter_screen.dart';
import 'package:app/layout/modules/login/login_screen.dart';
import 'package:app/layout/modules/messanger/messanger_screen.dart';
import 'package:app/layout/modules/null_safety/null_safety';
import 'package:app/layout/modules/users/users_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Counter(),
    ),
  );
}

//hello in first_branch