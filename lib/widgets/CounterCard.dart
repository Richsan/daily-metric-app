import 'package:daily_metric_app/bloc/CounterCubit.dart';
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
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => CounterCubit(),
        child: BlocBuilder<CounterCubit, int>(
          builder: (context, state) => CardItem(
            heading: metricName,
            subHeading: [
              _savingProgress,
            ],
            supportingText: 'Last Value',
            footerWidgets: [
              Text(state.toString()),
              Spacer(),
              IconButton(
                icon: const Icon(Icons.add_circle_outline_outlined),
                onPressed: () {
                  BlocProvider.of<CounterCubit>(context).add();
                  BlocProvider.of<MetricBloc>(context).add(
                    StoreMetric(
                      metric: Metric<int>(
                        name: metricName,
                        type: MetricType.Numeric,
                        value: 1,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      );
}
