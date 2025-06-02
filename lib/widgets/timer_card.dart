import 'package:daily_metric_app/bloc/timer_cubit.dart';
import 'package:daily_metric_app/screens/metric_values.dart';
import 'package:daily_metric_app/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/metric/metric_bloc.dart';
import '../models/metric.dart';
import 'saving_progress.dart';

class TimerCard extends StatelessWidget {
  TimerCard({
    Key? key,
    required this.metricName,
  })  : _savingProgress = MetricSavingProgress(metricName: metricName),
        super(key: key);

  final String metricName;
  final Widget _savingProgress;

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => TimerCubit(),
        child: BlocBuilder<TimerCubit, TimerState>(
          builder: (context, state) => CardItem(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MetricValuesScreen(metricName: metricName),
            )),
            heading: metricName,
            subHeading: [
              _savingProgress,
            ],
            supportingText: 'Timer:',
            footerWidgets: [
              Text(state.seconds.toString()),
              Spacer(),
              IconButton(
                icon: Icon(Icons.save_alt),
                onPressed: () {
                  BlocProvider.of<MetricBloc>(context).add(
                    StoreMetric(
                      metric: Metric<int>(
                        name: metricName,
                        type: MetricType.Timer,
                        value: state.seconds,
                      ),
                    ),
                  );
                  BlocProvider.of<TimerCubit>(context).reset();
                },
              ),
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () => BlocProvider.of<TimerCubit>(context).reset(),
              ),
              if (state.stopped == true)
                IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: () => BlocProvider.of<TimerCubit>(context).start(),
                )
              else
                IconButton(
                  icon: Icon(Icons.pause),
                  onPressed: () => BlocProvider.of<TimerCubit>(context).stop(),
                ),
            ],
          ),
        ),
      );
}
