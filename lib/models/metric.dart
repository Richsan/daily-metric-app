class Metric<T> {
  Metric({
    required this.value,
    DateTime? metricMoment,
    required this.type,
    required this.name,
  }) : metricMoment = metricMoment ?? DateTime.now();

  final T value;
  final DateTime metricMoment;
  final MetricType type;
  final String name;

  Metric<T> copyWith({
    T? newValue,
    DateTime? newMoment,
    String? newName,
  }) =>
      Metric(
        value: newValue ?? value,
        metricMoment: newMoment ?? metricMoment,
        type: type,
        name: newName ?? name,
      );
}

enum MetricType {Counter, Numeric, Timer}

