// ignore_for_file: prefer_const_constructors, must_be_immutable, unnecessary_brace_in_string_interps, avoid_print

import 'package:app/modules/counter/cubit/cubit.dart';
import 'package:app/modules/counter/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Counter extends StatelessWidget {
  Counter({super.key});

  int counter = 1;

  @override
  Widget build(BuildContext context) {
    //here u want object and call it

    return BlocProvider(
      create: (context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (context, state) => {
          if (state is CounterMinusState)
            {
              print('minus state ${state.counter}'),
            },
          if (state is CounterPlusState)
            {
              print('plus state ${state.counter}'),
            },
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Text(
                'Counter',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        CounterCubit.get(context).minus();
                      },
                      child: Text('MINUS')),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      '${CounterCubit.get(context).counter}',
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        CounterCubit.get(context).plus();
                      },
                      child: Text('PLUS')),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
