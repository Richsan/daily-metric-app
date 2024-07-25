import 'package:daily_metric_app/widgets/Card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/metric/metric_bloc.dart';
import '../models/Metric.dart';
import 'SavingProgress.dart';

class CounterCard extends StatelessWidget {
  CounterCard({
    Key? key,
    required this.metricName,
  })  : _savingProgress = MetricSavingProgress(metricName: metricName),
        super(key: key);

  final String metricName;
  final Widget _savingProgress;

  @override
  Widget build(BuildContext context) => BlocBuilder<MetricBloc, MetricState>(
      buildWhen: (previous, current) =>
          current is StoredMetric &&
          (current.metric?.type == MetricType.Counter) &&
          (current.metric?.name == metricName),
      builder: (context, state) {
        final DateTime? value = state.metric?.metricMoment;
        return CardItem(
          heading: metricName,
          subHeading: [
            _savingProgress,
          ],
          supportingText: 'Last Value',
          footerWidgets: [
            Text(value?.toLocal().toString() ?? ''),
            Spacer(),
            IconButton(
              icon: const Icon(Icons.add_circle_outline_outlined),
              onPressed: () {
                BlocProvider.of<MetricBloc>(context).add(
                  StoreMetric(
                    metric: Metric<int>(
                      name: metricName,
                      type: MetricType.Counter,
                      value: 1,
                    ),
                  ),
                );
              },
            )
          ],
        );
      });
}
