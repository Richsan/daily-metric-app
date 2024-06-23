import 'package:daily_metric_app/bloc/TimerCubit.dart';
import 'package:daily_metric_app/widgets/Card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerCard extends StatelessWidget {
  const TimerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => TimerCubit(),
        child: BlocBuilder<TimerCubit, TimerState>(
          builder: (context, state) => CardItem(
            heading: 'Card Name',
            subHeading: 'Last Value',
            footerWidgets: [
              Text(state.seconds.toString()),
              Spacer(),
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
