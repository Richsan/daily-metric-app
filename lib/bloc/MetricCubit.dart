import 'package:flutter_bloc/flutter_bloc.dart';

class MetricCubit extends Cubit<num> {
  MetricCubit() : super(0);

  void addMetric(num n) => emit(n);
}