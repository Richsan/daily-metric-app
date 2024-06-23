import 'package:daily_metric_app/bloc/CounterCubit.dart';
import 'package:daily_metric_app/widgets/Card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCard extends StatelessWidget {
  const CounterCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => CounterCubit(),
        child: BlocBuilder<CounterCubit, int>(
          builder: (context, state) => CardItem(
            heading: 'Card Name',
            subHeading: 'Last Value',
            footerWidgets: [
              Text(state.toString()),
              Spacer(),
              IconButton(
                icon: Icon(Icons.add_circle_outline_outlined),
                onPressed: () => BlocProvider.of<CounterCubit>(context).add(),
              )
            ],
          ),
        ),
      );
}
