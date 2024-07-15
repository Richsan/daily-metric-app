part of 'metric_bloc.dart';

abstract class MetricState extends Equatable {
  const MetricState({required this.metric,});

  final Metric? metric;

  @override
  List<Object?> get props => [
    metric,
  ];

}

class NewMetric extends MetricState {
  const NewMetric({required super.metric,});
}

class InitialState extends MetricState {
  const InitialState(): super(metric: null);

}

class StoredMetric extends MetricState {
  const StoredMetric({required super.metric,});

}