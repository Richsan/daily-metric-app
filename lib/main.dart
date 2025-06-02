import 'package:daily_metric_app/bloc/metric/metric_bloc.dart';
import 'package:daily_metric_app/widgets/counter_card.dart';
import 'package:daily_metric_app/widgets/metric_card.dart';
import 'package:daily_metric_app/widgets/timer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_draggable_gridview/flutter_draggable_gridview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Metric App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Daily Metric App Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(title)),
        body: BlocProvider(
          create: (context) => MetricBloc(),
          child: DraggableGridViewBuilder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 2),
            ),
            dragCompletion: (list, beforeIndex, afterIndex) {},
            children: [
              DraggableGridItem(
                isDraggable: true,
                child: TimerCard(
                  metricName: 'temporizador',
                ),
              ),
              DraggableGridItem(
                isDraggable: true,
                child: CounterCard(
                  metricName: 'contador',
                ),
              ),
              DraggableGridItem(
                isDraggable: true,
                child: MetricCard(metricName: 'metrica'),
              ),
            ],
            dragFeedback: (list, index) {
              print(list);
              return PlaceHolderWidget(
                child: Container(
                  color: Colors.red,
                ),
              );
            },
          ),
          /* floatingActionButton: FloatingActionButton(
      onPressed: () {},
      tooltip: 'Increment Counter',
      child: const Icon(Icons.add),
    ),*/
        ),
      );
}
