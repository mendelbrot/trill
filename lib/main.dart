import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'Trill',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: HomeStack(),
      ),
    );
  }
}

class AppState extends ChangeNotifier {
  List<Widget> timers = [];

  void addNewTimer() {
    timers.add(
      SingleTimer(key: UniqueKey()),
    );
    notifyListeners();
  }

  void removeTimer(Key key) {
    int index = timers.indexWhere((t) => t.key == key);
    timers.removeAt(index);
    notifyListeners();
  }

  void onReorderCallback(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    Widget t = timers.removeAt(oldIndex);
    timers.insert(newIndex, t);
    notifyListeners();
  }
}

class HomeStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    final theme = Theme.of(context);

    return Scaffold(
      body: ReorderableListView(
        header: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            appState.addNewTimer();
          },
        ),
        onReorder: appState.onReorderCallback,
        children: [for (var timer in appState.timers) timer],
      ),
    );
  }
}

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

  String get _timerString {
    final duration = Duration(seconds: _seconds);
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(_timerString, style: style),
          ),
          Row(
            children: [
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
    );
  }
}
