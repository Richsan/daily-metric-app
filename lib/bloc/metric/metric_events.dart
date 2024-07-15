part of 'metric_bloc.dart';

abstract class MetricEvent extends Equatable {
  const MetricEvent();

}

class StoreMetric extends MetricEvent {
  StoreMetric({required this.metric,});

  final Metric metric;

  @override
  List<Object?> get props => [
    metric,
  ];


}