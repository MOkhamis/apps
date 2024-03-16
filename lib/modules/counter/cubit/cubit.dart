// ignore_for_file: non_constant_identifier_names

import 'package:app/modules/counter/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//cubit carry one class (carry the logic )
class CounterCubit extends Cubit<CounterStates> {
  //to initialize
  CounterCubit() : super(CounterInitialState());

  //to be more easily when use this cubit in many places
  static CounterCubit get(context) => BlocProvider.of(context);

  int counter = 1;

  void minus() {
    counter--;
    emit(CounterMinusState(counter));
    //(emit)to show the state in ui
  }

  void plus() {
    counter++;
    emit(CounterPlusState(counter));
    //(emit)to show the state in ui
  }
}
