import 'package:daily_metric_app/components/repository.dart';
import 'package:daily_metric_app/widgets/metric_list.dart';
import 'package:flutter/material.dart';

class MetricValuesScreen extends StatelessWidget {
  const MetricValuesScreen({
    super.key,
    required this.metricName,
  });

  final String metricName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$metricName - Samples')),
      body: FutureBuilder(
        future: getMetrics(metricName),
        builder: (context, snapshot) => MetricList(
          metricName: metricName,
          metrics: snapshot.data ?? [],
        ),
      ),
    );
  }
}
