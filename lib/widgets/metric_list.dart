import 'package:daily_metric_app/adapters/date.dart';
import 'package:daily_metric_app/models/metric.dart';
import 'package:flutter/material.dart';

class MetricList extends StatelessWidget {
  const MetricList({
    super.key,
    required this.metricName,
    this.metrics = const [],
  });

  final List<Metric> metrics;
  final String metricName;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: metrics.length,
      itemBuilder: (context, index) => Card(
        child: ListTile(
          leading: Text(metrics[index].metricMoment.toDateStr()),
          title: Text(metrics[index].value.toString()),
          trailing: SizedBox(
            width: 50,
            height: 20,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.blue,
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
