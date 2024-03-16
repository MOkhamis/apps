// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'package:app/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:app/modules/done_tasks/done_tasks_screen.dart';
import 'package:app/modules/new_tasks/new_tasks_screen.dart';
import 'package:app/shared/cubit/states.dart';
import 'package:app/shared/networks/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  //to call object from Cubit
  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  //Toggle between 3 options List
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];

  List<dynamic> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
  //ButtomNavigationBar

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeButtomNavBarState());
  }

  bool isDark = false;
  void changeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBool(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}
