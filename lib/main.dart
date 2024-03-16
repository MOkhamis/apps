// ignore_for_file: prefer_const_constructors, unused_import, deprecated_member_use, prefer_const_constructors_in_immutables

import 'package:app/layout/news_app/cubit/cubit.dart';
import 'package:app/layout/news_app/news_layout.dart';
import 'package:app/layout/todo_app/todo_app_layout.dart';
import 'package:app/shared/bloc_observer.dart';
import 'package:app/shared/cubit/cubit.dart';
import 'package:app/shared/cubit/states.dart';
import 'package:app/shared/networks/local/cache_helper.dart';
import 'package:app/shared/networks/remote/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  //يتأكد ان كل حاجه هنا في الميثود خلصت وبعدين يفتح الابليكيشن
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  //future

  bool isDark = CacheHelper.getBool(key: 'isDark');

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp(this.isDark, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          //bloProvider once Time in App And take from it many
          //in creating  getBussines --> to get data
          create: (context) => NewsCubit()
            ..getBusiness()
            ..getSports()
            ..getScience(),
          //to load all data once time
        ),
        BlocProvider(
          create: (context) => AppCubit()..changeMode(fromShared: isDark),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              // primarySwatch: Colors.deepOrange,
              textTheme: TextTheme(
                bodyText1: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.black),
              ),
              appBarTheme: AppBarTheme(
                  iconTheme: IconThemeData(size: 30),
                  backgroundColor: Colors.white,
                  titleSpacing: 20,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarBrightness: Brightness.light),
                  titleTextStyle: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                  actionsIconTheme: IconThemeData()),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                backgroundColor: Colors.white,
              ),
            ),
            darkTheme: ThemeData(
              // bodyMedium  fontSize: 25, fontWeight: FontWeight.bold
              textTheme: TextTheme(
                bodyText1: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white),
              ),
              scaffoldBackgroundColor: Color(0xff43474E),
              appBarTheme: AppBarTheme(
                  iconTheme: IconThemeData(size: 30),
                  backgroundColor: Color(0xff43474E),
                  titleSpacing: 20,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Color(0xff43474E),
                      statusBarBrightness: Brightness.light),
                  titleTextStyle: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  actionsIconTheme: IconThemeData(color: Colors.white)),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                backgroundColor: Color(0xff43474E),
              ),
            ),
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: NewsLayout(),
          );
        },
      ),
    );
  }
}

//hello in first_branch