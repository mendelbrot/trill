import 'package:flutter/material.dart';
import 'package:trill/time_string.dart';

class TimeDisplay extends StatelessWidget {
  final int _seconds;

  const TimeDisplay({Key? key, required int seconds})
    : _seconds = seconds,
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: FittedBox(
          alignment: Alignment.centerRight,
          fit: BoxFit.contain,
          child: Padding(
            padding: const EdgeInsets.only(right: 2),
            child: Text(
              secondsToTimeString(_seconds),
              style: TextStyle(fontFamily: 'monospace'),
            ),
          ),
        ),
      ),
    );
  }
}
