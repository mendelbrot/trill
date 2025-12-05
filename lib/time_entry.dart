import 'package:flutter/material.dart';
import 'package:trill/time_display.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

final ButtonStyle filledButtonStyle = FilledButton.styleFrom(
  padding: EdgeInsets.zero,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
);

final ButtonStyle outlinedButtonStyle = OutlinedButton.styleFrom(
  padding: EdgeInsets.zero,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
);

final buttonTextStyle = TextStyle(fontSize: 20);

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
        title: Text(''),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TimeDisplay(seconds: _initialSeconds, absolute: true),
          ),
          GridView.count(
            shrinkWrap: true,
            childAspectRatio: 1.618,
            crossAxisCount: 4,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            padding: EdgeInsets.all(10.0),
            physics: const NeverScrollableScrollPhysics(),
            children: [
              OutlinedButton(
                style: outlinedButtonStyle,
                child: Text("+5s", style: buttonTextStyle),
                onPressed: () {
                  setState(() {
                    _initialSeconds += 5;
                  });
                },
              ),
              OutlinedButton(
                style: outlinedButtonStyle,
                child: Text("+10s", style: buttonTextStyle),
                onPressed: () {
                  setState(() {
                    _initialSeconds += 10;
                  });
                },
              ),
              OutlinedButton(
                style: outlinedButtonStyle,
                child: Text("+30s", style: buttonTextStyle),
                onPressed: () {
                  setState(() {
                    _initialSeconds += 30;
                  });
                },
              ),
              OutlinedButton(
                style: outlinedButtonStyle,
                child: Text("+1m", style: buttonTextStyle),
                onPressed: () {
                  setState(() {
                    _initialSeconds += 60;
                  });
                },
              ),
              OutlinedButton(
                style: outlinedButtonStyle,
                child: Text("+5m", style: buttonTextStyle),
                onPressed: () {
                  setState(() {
                    _initialSeconds += 300;
                  });
                },
              ),
              OutlinedButton(
                style: outlinedButtonStyle,
                child: Text("+10m", style: buttonTextStyle),
                onPressed: () {
                  setState(() {
                    _initialSeconds += 600;
                  });
                },
              ),
              OutlinedButton(
                style: outlinedButtonStyle,
                child: Text("+30m", style: buttonTextStyle),
                onPressed: () {
                  setState(() {
                    _initialSeconds += 1800;
                  });
                },
              ),
              OutlinedButton(
                style: outlinedButtonStyle,
                child: Text("+1h", style: buttonTextStyle),
                onPressed: () {
                  setState(() {
                    _initialSeconds += 3600;
                  });
                },
              ),
            ],
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 3.236,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            padding: EdgeInsets.all(10.0),
            physics: const NeverScrollableScrollPhysics(),
            children: [
              FilledButton(
                style: filledButtonStyle,
                child: Text("Zero", style: buttonTextStyle),
                onPressed: () {
                  setState(() {
                    _initialSeconds = 0;
                  });
                },
              ),
              OutlinedButton(
                style: filledButtonStyle,
                child: Text("Set", style: buttonTextStyle),
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
