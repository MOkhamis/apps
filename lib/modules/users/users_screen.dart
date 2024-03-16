// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:app/models/user/user_model.dart';
import 'package:flutter/material.dart';

class Users extends StatelessWidget {
  Users({super.key});

  List<DataModel> users = [
    DataModel(id: 1, name: 'Mohamed khamis', phone: '(+02)010657898009'),
    DataModel(id: 2, name: 'Mohamed khamis', phone: '(+02)010657898009'),
    DataModel(id: 3, name: 'Mohamed khamis', phone: '(+02)010657898009'),
    DataModel(id: 4, name: 'Mohamed khamis', phone: '(+02)010657898009'),
    DataModel(id: 6, name: 'Mohamed khamis', phone: '(+02)010657898009'),
    DataModel(id: 7, name: 'Mohamed khamis', phone: '(+02)010657898009'),
    DataModel(id: 8, name: 'Mohamed khamis', phone: '(+02)010657898009'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Users',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.separated(
          itemBuilder: ((context, index) => buildUsersItems(users[index])),
          separatorBuilder: (context, index) => SizedBox(
                height: 20,
              ),
          itemCount: users.length),
    );
  }

  Widget buildUsersItems(DataModel user) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Color(0xFF03355E),
            child: Text(
              '${user.id}',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${user.name}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                '${user.phone}',
                style: TextStyle(color: Colors.grey),
              )
            ],
          )
        ],
      ),
    );
  }
}
