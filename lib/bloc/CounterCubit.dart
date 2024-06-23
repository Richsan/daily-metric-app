import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void add({int num = 1}) => emit(state + num);
  void subract({int num = 1}) => emit(state - num);
  void setTo(int num) => emit(num);
  void reset() => emit(0);
}