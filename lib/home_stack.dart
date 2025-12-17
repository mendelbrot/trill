import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trill/app_state.dart';

class HomeStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.inverseSurface,
        body: ReorderableListView(
          header: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FilledButton(
              style: FilledButton.styleFrom(
                side: BorderSide(
                  color: theme.colorScheme.onPrimary,
                  width: 1.0,
                  style: BorderStyle.solid,
                ),
              ),
              child: const Icon(Icons.add),
              onPressed: () {
                appState.addNewTimer();
              },
            ),
          ),
          onReorder: appState.onReorderCallback,
          children: [for (var timer in appState.timers) timer],
        ),
      ),
    );
  }
}
