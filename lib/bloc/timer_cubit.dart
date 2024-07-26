import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class TimerState {
  TimerState({
    this.seconds = 0,
    this.stopped = true,
  });

  final int seconds;
  final bool stopped;

  TimerState copyWith({int? seconds, bool? stopped}) => TimerState(
        seconds: seconds ?? this.seconds,
        stopped: stopped ?? this.stopped,
      );
}

class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(TimerState());

  StreamSubscription<void>? _tickStream;

  void tick() => emit(state.copyWith(seconds: state.seconds + 1));

  void reset() => emit(state.copyWith(seconds: 0));

  void stop() {
    _tickStream?.pause();
    emit(state.copyWith(stopped: true));
  }

  void start() async {
    if(_tickStream?.isPaused == true) {
      _tickStream?.resume();
    } else {
      _tickStream = Stream.periodic(
        const Duration(seconds: 1),
        (_) => tick(),
      ).listen((_) {});
    }

    emit(state.copyWith(stopped: false));
  }
}
