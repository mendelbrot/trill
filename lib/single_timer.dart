import 'dart:async';
import 'package:flutter/material.dart';
import 'package:trill/app_state.dart';
import 'package:trill/time_display.dart';
import 'package:trill/time_entry.dart';
import 'package:provider/provider.dart';
import 'package:animated_mesh_gradient/animated_mesh_gradient.dart';
import 'package:audioplayers/audioplayers.dart';

/// Width (logical px) at which the timer card is laid out before being
/// uniformly scaled to fit the available width.
const double kTimerDesignWidth = 400;

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

  final TextEditingController _timerNameController = TextEditingController();

  final _player = AudioPlayer();

  @override
  void dispose() {
    _timer?.cancel();
    _timerNameController.dispose();
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

    Widget InnerUI = Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextField(
                  controller: _timerNameController,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              // Nudged into the card's top/right padding; the tap area and
              // hover highlight move with it.
              Transform.translate(
                offset: const Offset(0, -0),
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    appState.removeTimer(widget.key!);
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TimeDisplay(seconds: _seconds, noScreenBg: _isSoundingAlarm),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TimeDisplay(
                    seconds: _initialSeconds,
                    absolute: true,
                    noScreenBg: _isSoundingAlarm,
                  ),
                ),
                Expanded(
                  // Nudged into the card's bottom/right padding; tap areas
                  // and hover highlights move with it.
                  child: Transform.translate(
                    offset: const Offset(0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _isRunning
                            ? IconButton(
                                icon: const Icon(Icons.pause),
                                onPressed: _isSoundingAlarm ? null : pauseTimer,
                              )
                            : IconButton(
                                icon: const Icon(Icons.play_arrow),
                                onPressed: _isSoundingAlarm ? null : startTimer,
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
                ),
              ],
            ),
          ),
        ],
      ),
    );

    Widget card = _isSoundingAlarm
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

    // Lay the card out at a fixed design width, then scale it uniformly to
    // the available width so every element keeps the same relative size.
    // The SizedBox forces full width, since ReorderableListView hands its
    // items loose constraints (which would stop fitWidth from scaling up).
    // Long-pressing anywhere on the card starts a reorder drag.
    return ReorderableDelayedDragStartListener(
      index: appState.timers.indexWhere((t) => t.key == widget.key),
      child: SizedBox(
        width: double.infinity,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: SizedBox(
            width: kTimerDesignWidth,
            // Larger icons (30px vs default 24px) with the default 8px
            // padding: 46px button, padded to a 48px tap target.
            child: IconButtonTheme(
              data: IconButtonThemeData(
                style: IconButton.styleFrom(
                  iconSize: 30,
                  padding: const EdgeInsets.all(8),
                ),
              ),
              child: card,
            ),
          ),
        ),
      ),
    );
  }
}
