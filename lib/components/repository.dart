import 'package:daily_metric_app/models/metric.dart';

final _metricMaps = {};
final _database =
    Future.delayed(Duration(seconds: 4)).then((value) => _metricMaps);

Future<List<Metric>> getMetrics(String metricName) async {
  return (await _database)[metricName];
}

Future<void> saveMetric(Metric metric) async {
  final List<Metric> metrics = (await _database)[metric.name] ?? [];
  metrics.add(metric);

  (await _database)[metric.name] = metrics;
}
