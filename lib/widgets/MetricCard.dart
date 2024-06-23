import 'package:daily_metric_app/bloc/MetricCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Card.dart';

class MetricDialogBox extends StatefulWidget {

  @override
  _MetricDialogBoxState createState() => _MetricDialogBoxState();
}

class _MetricDialogBoxState extends State<MetricDialogBox> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Metric value:'),
      content: TextField(
        autofocus: true,
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+\.?[0-9]*'))],
        decoration: InputDecoration(
          hintText: 'input the metric value',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(controller.text),
          child: Text('submit'),
        ),
      ],
    );
  }
}

class MetricCard extends StatelessWidget {
  const MetricCard({Key? key}) : super(key: key);


  Future<String?> _openDialog(BuildContext context) =>
      showDialog<String>(context: context,
        builder: (context) => MetricDialogBox(),);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => MetricCubit(),
        child: BlocBuilder<MetricCubit, num>(
          builder: (context, state) => CardItem(
            heading: 'Metric Card',
            subHeading: 'Last Value',
            footerWidgets: [
              Text(state.toString()),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.add_box_outlined),
                onPressed: () => _openDialog(context)
                    .then((valueStr) => num.parse(valueStr!))
                    .then((metricValue) => BlocProvider.of<MetricCubit>(context)
                        .addMetric(metricValue)),
              ),
            ],
          ),
        ),
      );
}