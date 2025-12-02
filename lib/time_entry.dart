import 'package:flutter/material.dart';
import 'package:trill/time_string.dart';

class TimeEntry extends StatefulWidget {
  final Function onSubmit;
  final int initialSeconds;

  const TimeEntry({
    Key? key,
    required this.onSubmit,
    required int initialSeconds,
  }) : initialSeconds = initialSeconds,
       super(key: key);

  @override
  State<TimeEntry> createState() => _TimeEntryState();
}

class _TimeEntryState extends State<TimeEntry> {
  int _initialSeconds = 0;

  @override
  void initState() {
    super.initState();
    _initialSeconds = widget.initialSeconds;
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
      body: Column(
        children: [
          Row(children: [Text(secondsToTimeString(_initialSeconds))]),
          Row(
            children: [
              ElevatedButton(
                child: Text("+1m"),
                onPressed: () {
                  setState(() {
                    _initialSeconds += 60;
                  });
                },
              ),
              ElevatedButton(
                child: Text("+2m"),
                onPressed: () {
                  setState(() {
                    _initialSeconds += 120;
                  });
                },
              ),
              ElevatedButton(
                child: Text("+3m"),
                onPressed: () {
                  setState(() {
                    _initialSeconds += 180;
                  });
                },
              ),
              ElevatedButton(
                child: Text("+5m"),
                onPressed: () {
                  setState(() {
                    _initialSeconds += 300;
                  });
                },
              ),
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                child: Text("+10m"),
                onPressed: () {
                  setState(() {
                    _initialSeconds += 600;
                  });
                },
              ),
              ElevatedButton(
                child: Text("+15m"),
                onPressed: () {
                  setState(() {
                    _initialSeconds += 900;
                  });
                },
              ),
              ElevatedButton(
                child: Text("+30m"),
                onPressed: () {
                  setState(() {
                    _initialSeconds += 1800;
                  });
                },
              ),
              ElevatedButton(
                child: Text("+1h"),
                onPressed: () {
                  setState(() {
                    _initialSeconds += 3600;
                  });
                },
              ),
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                child: Text("Clear"),
                onPressed: () {
                  setState(() {
                    _initialSeconds = 0;
                  });
                },
              ),
              ElevatedButton(
                child: Text("Set"),
                onPressed: () {
                  Navigator.of(context).pop();
                  widget.onSubmit(_initialSeconds);
                },
              ),
              ElevatedButton(
                child: Text("Set & Start"),
                onPressed: () {
                  Navigator.of(context).pop();
                  widget.onSubmit(_initialSeconds, true);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
