import 'package:daily_metric_app/components/repository.dart';
import 'package:daily_metric_app/models/metric.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'metric_events.dart';
part 'metric_states.dart';

class MetricBloc extends Bloc<MetricEvent, MetricState> {
  MetricBloc() : super(InitialState()) {
    on<StoreMetric>((event, emit) async {
      emit(NewMetric(metric: event.metric));

      await saveMetric(event.metric);

      emit(StoredMetric(metric: event.metric));
    });
  }
}
