import 'package:flutter_bloc/flutter_bloc.dart';

class NumberCubit extends Cubit<num> {
  NumberCubit() : super(0);

  void addNumber(num n) => emit(n);
}