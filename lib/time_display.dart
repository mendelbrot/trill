import 'package:flutter/material.dart';
import 'package:trill/time_string.dart';

class TimeDisplay extends StatelessWidget {
  final int _seconds;
  final bool _absolute;

  const TimeDisplay({Key? key, int seconds = 0, bool absolute = false})
    : _seconds = seconds,
      _absolute = absolute,
      super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AspectRatio(
      aspectRatio: 4,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: theme.colorScheme.tertiary, width: 1.0),
          borderRadius: BorderRadius.circular(4.0),
          color: theme.colorScheme.tertiaryContainer,
        ),
        child: FittedBox(
          alignment: _absolute ? Alignment.center : Alignment.centerRight,
          fit: BoxFit.contain,
          child: Padding(
            padding: _absolute ? EdgeInsets.zero : EdgeInsets.only(right: 2),
            child: Text(
              secondsToTimeString(_seconds),
              style: TextStyle(
                fontFamily: 'monospace',
                // color: theme.colorScheme.onTertiary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
