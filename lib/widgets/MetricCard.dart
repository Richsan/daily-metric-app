import 'package:daily_metric_app/bloc/metric/metric_bloc.dart';
import 'package:daily_metric_app/models/Metric.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Card.dart';
import 'SavingProgress.dart';

class MetricDialogBox extends StatefulWidget {
  const MetricDialogBox({
    super.key,
    required this.metricName,
  });

  final String metricName;

  @override
  _MetricDialogBoxState createState() =>
      _MetricDialogBoxState(metricName: metricName);
}

Future<DateTime?> showDateTimePicker({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  initialDate ??= DateTime.now();
  firstDate ??= initialDate.subtract(const Duration(days: 365 * 100));
  lastDate ??= firstDate.add(const Duration(days: 365 * 200));

  final DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
  );

  if (selectedDate == null) return null;

  if (!context.mounted) return selectedDate;

  final TimeOfDay? selectedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.fromDateTime(initialDate),
  );

  return selectedTime == null
      ? selectedDate
      : DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
}

class _MetricDialogBoxState extends State<MetricDialogBox> {
  _MetricDialogBoxState({
    required this.metricName,
  });

  late TextEditingController metricController;
  late TextEditingController dateTimeController;
  final String metricName;

  @override
  void initState() {
    super.initState();
    metricController = TextEditingController();
    dateTimeController = TextEditingController(text: DateTime.now().toString());
  }

  @override
  void dispose() {
    super.dispose();
    metricController.dispose();
    dateTimeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Metric value:'),
      content: Column(
        children: [
          TextField(
            onTap: () async {
              final newDate = await showDateTimePicker(context: context);
              dateTimeController.text = newDate?.toString() ?? "";
            },
            controller: dateTimeController,
          ),
          TextField(
            autofocus: true,
            controller: metricController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+\.?[0-9]*'))
            ],
            decoration: InputDecoration(
              hintText: 'input the metric value',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(Metric(
            value: num.parse(metricController.text),
            metricMoment: DateTime.parse(dateTimeController.text),
            type: MetricType.Numeric,
            name: metricName,
          )),
          child: Text('submit'),
        ),
      ],
    );
  }
}

class MetricCard extends StatelessWidget {
  MetricCard({
    Key? key,
    required this.metricName,
  })  : _savingProgress = MetricSavingProgress(metricName: metricName),
        super(key: key);

  final String metricName;
  final Widget _savingProgress;

  Future<Metric<num>?> _openDialog(BuildContext context) =>
      showDialog<Metric<num>>(
        context: context,
        builder: (context) => MetricDialogBox(
          metricName: metricName,
        ),
      );

  @override
  Widget build(BuildContext context) => BlocBuilder<MetricBloc, MetricState>(
        buildWhen: (previous, current) =>
            current is StoredMetric &&
            (current.metric?.type == MetricType.Numeric) &&
            (current.metric?.name == metricName),
        builder: (context, state) {
          final num? currentValue = state.metric?.value;

          return CardItem(
            heading: metricName,
            subHeading: [
              _savingProgress,
            ],
            supportingText: 'Last Value',
            footerWidgets: [
              Text(currentValue.toString()),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.add_box_outlined),
                onPressed: () => _openDialog(context)
                    .then((metric) => metric?.value ?? 0)
                    .then(
                  (metricValue) {
                    BlocProvider.of<MetricBloc>(context).add(
                      StoreMetric(
                        metric: Metric<num>(
                          name: metricName,
                          type: MetricType.Numeric,
                          value: metricValue,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      );
}

Widget _circularProgressWithText({required int percentage, String? text}) {
  var value = percentage / 100.0;
  var size = 42.0;

  text ??= '$percentage%';

  return Stack(
    alignment: AlignmentDirectional.center,
    children: <Widget>[
      Center(
        child: SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            value: value,
          ),
        ),
      ),
      Center(child: Text(text)),
    ],
  );
}
