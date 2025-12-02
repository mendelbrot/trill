import 'dart:async';
import 'package:flutter/material.dart';
import 'package:trill/app_state.dart';
import 'package:trill/time_entry.dart';
import 'package:trill/time_string.dart';
import 'package:provider/provider.dart';

class SingleTimer extends StatefulWidget {
  const SingleTimer({super.key});

  @override
  State<SingleTimer> createState() => _SingleTimerState();
}

class _SingleTimerState extends State<SingleTimer> {
  Timer? _timer;
  int _initialSeconds = 0;
  int _seconds = 0;
  bool _isRunning = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Timer timerFactory() {
    bool isCountingDownMode = _initialSeconds > 0;
    if (isCountingDownMode) {
      return Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _seconds--;
        });
      });
    } else {
      return Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _seconds++;
        });
      });
    }
  }

  void startTimer() {
    if (!_isRunning) {
      _timer = timerFactory();
      setState(() {
        _isRunning = true;
      });
    }
  }

  void pauseTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void resetTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _seconds = _initialSeconds;
    });
  }

  void setTimer(int seconds, [bool start = false]) {
    setState(() {
      _initialSeconds = seconds;
      _seconds = seconds;
      if (start) {
        startTimer();
      }
    });
  }

  void gotoTimeEntry() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            TimeEntry(onSubmit: setTimer, initialSeconds: _initialSeconds),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    final theme = Theme.of(context);
    final timeTextStyle = theme.textTheme.displayLarge!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    final initialTimeTextStyle = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(secondsToTimeString(_seconds), style: timeTextStyle),
            Row(
              children: [
                OutlinedButton(
                  onPressed: gotoTimeEntry,
                  child: Text(
                    secondsToTimeString(_initialSeconds),
                    style: initialTimeTextStyle,
                  ),
                ),
                _isRunning
                    ? IconButton(
                        icon: const Icon(Icons.pause),
                        color: theme.colorScheme.onPrimary,
                        onPressed: () {
                          pauseTimer();
                        },
                      )
                    : IconButton(
                        icon: const Icon(Icons.play_arrow),
                        color: theme.colorScheme.onPrimary,
                        onPressed: () {
                          startTimer();
                        },
                      ),
                IconButton(
                  icon: const Icon(Icons.replay),
                  color: theme.colorScheme.onPrimary,
                  onPressed: () {
                    resetTimer();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  color: theme.colorScheme.onPrimary,
                  onPressed: () {
                    appState.removeTimer(widget.key!);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
