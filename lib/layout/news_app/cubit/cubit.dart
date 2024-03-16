// ignore_for_file: prefer_const_constructors, avoid_print, prefer_is_empty

import 'package:app/layout/news_app/cubit/states.dart';
import 'package:app/modules/business/business_screen.dart';
import 'package:app/modules/science/science_screen.dart';
import 'package:app/modules/sports/sports_screen.dart';
import 'package:app/shared/networks/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates> {
  //to init cubit
  NewsCubit() : super(NewsInitialState());

  //to be more easliy to call object from cubit
  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> buttomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'science'),
    // BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'setting'),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    // SettingScreen(),
  ];

  void changeBottomAppBar(int index) {
    currentIndex = index;
    // if (index == 1) {
    //   getSports();
    // }
    // //onPressed reload data
    // if (index == 2) {
    //   getScience();
    // }

    emit(NewsButtomNavState());
  }

//https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=cb9339b8c436452387f42535e3047564
  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsBusinessLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'us',
        'category': 'business',
        'apiKey': 'cb9339b8c436452387f42535e3047564'
      },
    ).then(
      (value) {
        // print(value?.data['articles'][0]['title']),
        business = value?.data['articles'];
        print(business[0]['title']);

        emit(NewsBusinessSuccessState());
      },
    ).catchError((error) {
      print(error.toString());
      emit(NewsBusinessErrorState(error.toString()));
    });
  }

// https://newsapi.org/v2/top-headlines?country=us&category=sport&apiKey=cb9339b8c436452387f42535e3047564
  List<dynamic> sports = [];

  void getSports() {
    emit(NewsSportsLoadingState());

    if (sports.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'us',
          'category': 'sport',
          'apiKey': 'cb9339b8c436452387f42535e3047564'
        },
      ).then(
        (value) {
          // print(value?.data['articles'][0]['title']),
          sports = value?.data['articles'];
          print(sports[0]['title']);

          emit(NewsSportsSuccessState());
        },
      ).catchError((error) {
        print(error.toString());
        emit(NewsSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsSportsSuccessState());
    }
  }

//https://newsapi.org/v2/top-headlines?country=us&category=science&apiKey=cb9339b8c436452387f42535e3047564
  List<dynamic> science = [];

  void getScience() {
    emit(NewsScienceLoadingState());

    if (science.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'us',
          'category': 'science',
          'apiKey': 'cb9339b8c436452387f42535e3047564'
        },
      ).then(
        (value) {
          // print(value?.data['articles'][0]['title']),
          science = value?.data['articles'];
          print(science[0]['title']);

          emit(NewsScienceSuccessState());
        },
      ).catchError((error) {
        print(error.toString());
        emit(NewsScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsScienceSuccessState());
    }
  }

//https://newsapi.org/v2/everything?q=bitcoin&apiKey=cb9339b8c436452387f42535e3047564

  List<dynamic> search = [];

  void getSearch(value) {
    emit(NewsSearchLoadingState());

    search = [];
    //to make it zero of list
    DioHelper.getData(
      url: 'v2/everything',
      query: {'q': '$value', 'apiKey': 'cb9339b8c436452387f42535e3047564'},
    ).then((value) {
      search = value!.data['articles'];
      print(search[0]['title']);

      emit(NewsSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsSearchErrorState(error.toString()));
    });
  }
}
