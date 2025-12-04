import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trill/app_state.dart';

class HomeStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    final theme = Theme.of(context);

    return Scaffold(
      body: ReorderableListView(
        header: ElevatedButton(
          child: const Icon(Icons.add),
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
