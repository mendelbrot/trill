import 'package:flutter/material.dart';
import 'package:trill/single_timer.dart';

class AppState extends ChangeNotifier {
  List<Widget> timers = [];

  void addNewTimer() {
    timers.insert(0, SingleTimer(key: UniqueKey()));
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
