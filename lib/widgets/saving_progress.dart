import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/metric/metric_bloc.dart';

class MetricSavingProgress extends StatelessWidget {
  MetricSavingProgress({super.key,
    required this.metricName,
    this.saveCounter = 0,});

  final String metricName;
  int saveCounter;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MetricBloc, MetricState>
      (listener: (context, state) {
      if(state is NewMetric) {
        saveCounter++;
      }

      if(state is StoredMetric) {
        saveCounter--;
      }
    },
        buildWhen: (previous, current) => current.metric?.name == metricName,
        listenWhen: (previous, current) => current.metric?.name == metricName,
        builder: (context, state) {
          if(saveCounter > 0) {
            return Row(
              children: <Widget>[
                SizedBox(
                  width: 12,
                  height: 12,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                ),
                SizedBox(width: 10,),
                Text('Saving: ${saveCounter}'),
              ],
            );
          }
          return SizedBox();
        });
  }
}
