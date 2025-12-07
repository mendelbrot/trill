import 'dart:async';
import 'package:flutter/material.dart';
import 'package:trill/app_state.dart';
import 'package:trill/time_display.dart';
import 'package:trill/time_entry.dart';
import 'package:provider/provider.dart';
import 'package:animated_mesh_gradient/animated_mesh_gradient.dart';
import 'package:audioplayers/audioplayers.dart';

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
  bool _isSoundingAlarm = false;

  final _player = AudioPlayer();

  @override
  void dispose() {
    _timer?.cancel();
    _player.dispose();
    super.dispose();
  }

  void soundAlarm() async {
    await _player.setReleaseMode(ReleaseMode.loop);
    await _player.play(AssetSource('soft-piano-72454.mp3'));
    setState(() {
      _isSoundingAlarm = true;
    });
  }

  void dismissAlarm() {
    _player.stop();
    setState(() {
      _isSoundingAlarm = false;
    });
  }

  Timer timerFactory() {
    bool isCountingDownMode = _initialSeconds > 0;
    if (isCountingDownMode) {
      return Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _seconds--;
          if (_seconds == 0) {
            soundAlarm();
          }
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
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _initialSeconds = seconds;
      _seconds = seconds;
      if (start) {
        _timer = timerFactory();
        _isRunning = true;
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

    Widget InnerUI = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
                child: TimeDisplay(
                  seconds: _seconds,
                  noScreenBg: _isSoundingAlarm,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TimeDisplay(
                        seconds: _initialSeconds,
                        absolute: true,
                        noScreenBg: _isSoundingAlarm,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _isRunning
                              ? IconButton(
                                  icon: const Icon(Icons.pause),
                                  onPressed: _isSoundingAlarm
                                      ? null
                                      : pauseTimer,
                                )
                              : IconButton(
                                  icon: const Icon(Icons.play_arrow),
                                  onPressed: _isSoundingAlarm
                                      ? null
                                      : startTimer,
                                ),
                          IconButton(
                            icon: const Icon(Icons.replay),
                            onPressed: _isSoundingAlarm ? null : resetTimer,
                          ),
                          IconButton(
                            icon: const Icon(Icons.dialpad),
                            onPressed: _isSoundingAlarm ? null : gotoTimeEntry,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            appState.removeTimer(widget.key!);
          },
        ),
      ],
    );

    return _isSoundingAlarm
        ? InkWell(
            onTap: dismissAlarm,
            child: Card(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                side: BorderSide(
                  width: 1.0,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              child: AnimatedMeshGradient(
                colors: [Colors.red, Colors.blue, Colors.green, Colors.yellow],
                options: AnimatedMeshGradientOptions(),
                child: InnerUI,
              ),
            ),
          )
        : Card(
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
              side: BorderSide(width: 1.0, color: theme.colorScheme.onPrimary),
            ),
            color: theme.colorScheme.primaryContainer,
            child: InnerUI,
          );
  }
}
