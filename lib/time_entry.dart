import 'package:flutter/material.dart';

class TimeEntry extends StatefulWidget {
  final Function onSubmit;
  final int initialSeconds;

  const TimeEntry({
    Key? key,
    required this.onSubmit,
    required this.initialSeconds,
  }) : super(key: key);

  @override
  State<TimeEntry> createState() => _TimeEntryState();
}

class _TimeEntryState extends State<TimeEntry> {
  int initialSeconds = 0;

  @override
  void initState() {
    super.initState();
    initialSeconds = widget.initialSeconds;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('set timer'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Placeholder(),
    );
  }
}
