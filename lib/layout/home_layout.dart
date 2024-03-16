// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, prefer_typing_uninitialized_variables, avoid_unnecessary_containers, prefer_is_empty, unused_import, unnecessary_import

import 'dart:async';

import 'package:app/layout/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:app/layout/modules/done_tasks/done_tasks_screen.dart';
import 'package:app/layout/modules/new_tasks/new_tasks_screen.dart';
import 'package:app/layout/shared/components/components.dart';
import 'package:app/layout/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;
  //Toggle between 3 options List

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

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

  //to can read it in all methods of database
  static late Database database;

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  var titleCon = TextEditingController();
  var timeCon = TextEditingController();
  var dateCon = TextEditingController();
  List<Map> tasks = [];

  @override
  void initState() {
    super.initState();

    //inside create will call the list(getDataFromDatabase)
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          titles[currentIndex],
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      //tasks.length == 1? Center(child: CircularProgressIndicator()):
      body: tasks.length == 0
          ? Center(child: CircularProgressIndicator())
          : screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        child: Icon(fabIcon),
        onPressed: () {
          if (isBottomSheetShown) {
            if (formKey.currentState!.validate()) {
              insertToDataBase(
                title: titleCon.text,
                time: timeCon.text,
                date: dateCon.text,
              ).then((value) {
                getDataFromDatabase(database).then((value) {
                  Navigator.pop(context);
                  setState(() {
                    isBottomSheetShown = false;
                    fabIcon = Icons.edit;

                    //when showshown show this icon
                    tasks = value;
                    print(tasks);
                  });
                });
              });
            }
          } else {
            scaffoldKey.currentState!
                .showBottomSheet(
                  elevation: 20,
                  (context) => Container(
                    padding: EdgeInsets.all(20),
                    color: Colors.white,
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          defaultTextFormField(
                            controller: titleCon,
                            type: TextInputType.text,
                            label: 'Add Task Title',
                            isPrefix: true,
                            prefix: Icons.title,
                            validate: (dynamic value) {
                              if (value == '') {
                                return '*required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultTextFormField(
                            controller: timeCon,
                            type: TextInputType.datetime,
                            label: 'Task Time',
                            isPrefix: true,
                            prefix: Icons.watch_later_outlined,
                            validate: (value) {
                              if (value == '') {
                                return 'time field is required';
                              }
                              return null;
                            },
                            //to showTimePicker onTap
                            onTap: () {
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then(
                                (value) {
                                  timeCon.text =
                                      value!.format(context).toString();
                                  return null;
                                },
                              );
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultTextFormField(
                            controller: dateCon,
                            type: TextInputType.text,
                            label: 'Date Time',
                            isPrefix: true,
                            prefix: Icons.calendar_month,
                            validate: (value) {
                              if (value == '') {
                                return 'Date field is required';
                              }
                              return null;
                            },
                            //to showTimePicker onTap
                            onTap: () {
                              showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                initialDate: DateTime.now(),
                                lastDate: DateTime.parse('2025-3-4'),
                              ).then(
                                (value) {
                                  //package intl
                                  dateCon.text =
                                      DateFormat.yMMMd().format(value!);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .closed
                .then((value) {
              isBottomSheetShown = false;

              setState(() {
                fabIcon = Icons.edit;
              });
              //when showshown show this icon
            });
            isBottomSheetShown = true;
            //to enter if loop more

            setState(() {
              fabIcon = Icons.add;
            });
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Done'),
          BottomNavigationBarItem(icon: Icon(Icons.archive), label: 'Archived'),
        ],
      ),
    );
  }

  void createDatabase() async {
    database = await openDatabase(
      'todo.db',
      version: 1,
      //create database
      onCreate: (database, version) {
        print('dataBase Created');

        //create the table in oncreate once time
        database
            .execute(
                'CREATE TABLE tasks(id INTEGER PRINMARY KEY, title TEXT ,date TEXT,time TEXT ,status TEXT)')
            .then(
          (value) {
            print('Table Created');
          },
        ).catchError(
          (error) {
            print('error when create table ${error.toString()}');
          },
        );
      },
      onOpen: (database) {
        getDataFromDatabase(database).then((value) {
          setState(() {
            tasks = value;
            print(tasks);
          });
        });
        print('dataBase Opened');
      },
    );
  }

  Future insertToDataBase({
    required dynamic title,
    required dynamic time,
    required dynamic date,
  }) async {
    //way 1
    // database.rawInsert('sql').then((value) => null).catchError((error) {});
    //way 2
    await database.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO tasks(title ,date ,time  ,status ) VALUES("$title","$date","$time","Active")')
          .then(
        (value) {
          print('$value the task 1 inserted  into table');
        },
      ).catchError((error) {
        print('the error when you insert the task to table');
      });
    });
  }

  Future<List<Map>> getDataFromDatabase(database) async {
    // Get the records  // and call it in onOpen in Creation
    return await database.rawQuery('SELECT * FROM tasks');
  }
}

//  FloatingActionButton(
//         onPressed: () {
//           //هو دلوقتي معروض قبل ما يعمل بوب ويروح لازم تعمله ال validate
//           if (isBottomSheetShown) {
//             if (formKey.currentState!.validate()) {
//               insertToDataBase(
//                 time: timeCon.text,
//                 title: titleCon.text,
//                 date: dateCon.text,
//               ).then(
//                 (value) {
//                   Navigator.pop(context);
//                   isBottomSheetShown = false;
//                   setState(() {
//                     fabIcon = Icons.edit;
//                   });
//                 },
//               );
//             }
//             // //.then --> to ensure that the data insetred then complete the code
//           } else {
//             scaffoldKey.currentState!
//                 .showBottomSheet(
//                   (context) => Container(
//                     padding: const EdgeInsets.all(20),
//                     color: Colors.grey[100],
//                     child: Form(
//                       key: formKey,
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           defaultTextFormField(
//                             controller: titleCon,
//                             type: TextInputType.name,
//                             label: 'add task',
//                             isPrefix: true,
//                             prefix: Icons.title,
//                             validate: (dynamic value) {
//                               if (value.isEmpty) {
//                                 return '*required';
//                               }
//                               return null;
//                             },
//                           ),
//                           SizedBox(
//                             height: 15,
//                           ),
//                           defaultTextFormField(
//                             controller: timeCon,
//                             type: TextInputType.datetime,
//                             label: 'Task Time',
//                             isPrefix: true,
//                             prefix: Icons.watch_later_outlined,
//                             validate: (dynamic value) {
//                               if (value.isEmpty) {
//                                 return 'time field is required';
//                               }
//                               return null;
//                             },
//                             //to showTimePicker onTap
//                             onTap: () {
//                               showTimePicker(
//                                       context: context,
//                                       initialTime: TimeOfDay.now())
//                                   .then(
//                                 (value) {
//                                   timeCon.text = value.toString();
//                                   return null;
//                                 },
//                               );
//                             },
//                           ),
//                           SizedBox(
//                             height: 15,
//                           ),
//                           defaultTextFormField(
//                             controller: dateCon,
//                             type: TextInputType.datetime,
//                             label: 'Date Time',
//                             isPrefix: true,
//                             prefix: Icons.calendar_view_day_outlined,
//                             validate: (value) {
//                               if (value.isEmpty) {
//                                 return 'Date field is required';
//                               }
//                               return null;
//                             },
//                             //to showTimePicker onTap
//                             onTap: () {
//                               showDatePicker(
//                                 context: context,
//                                 firstDate: DateTime.now(),
//                                 initialDate: DateTime.now(),
//                                 lastDate: DateTime.parse('2024-3-4'),
//                               ).then(
//                                 (value) {
//                                   //package intl
//                                   dateCon.text =
//                                       DateFormat.yMMMd().format(value!);

//                                   return null;
//                                 },
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 )
//                 .closed
//                 .then((value) {
//               isBottomSheetShown = false;
//               setState(() {
//                 fabIcon = Icons.edit;
//               });
//             });
//             isBottomSheetShown = true;
//             setState(() {
//               fabIcon = Icons.add;
//             });
//           }
//         },
//         child: Icon(fabIcon),
//       ),
