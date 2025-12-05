import 'package:flutter/material.dart';
import 'package:trill/time_string.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 1,
            childAspectRatio: 4,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1.0),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: FittedBox(
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  child: Text(
                    secondsToTimeString(_initialSeconds),
                    style: TextStyle(fontFamily: 'monospace'),
                  ),
                ),
              ),
            ],
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
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  // side: BorderSide(color: Colors.blue, width: 1.5),
                ),
                child: Text("+5s"),
                onPressed: () {
                  setState(() {
                    _initialSeconds += 5;
                  });
                },
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  // side: BorderSide(color: Colors.blue, width: 1.5),
                ),
                child: Text("+10s"),
                onPressed: () {
                  setState(() {
                    _initialSeconds += 10;
                  });
                },
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  // side: BorderSide(color: Colors.blue, width: 1.5),
                ),
                child: Text("+30s"),
                onPressed: () {
                  setState(() {
                    _initialSeconds += 30;
                  });
                },
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  // side: BorderSide(color: Colors.blue, width: 1.5),
                ),
                child: Text("+1m"),
                onPressed: () {
                  setState(() {
                    _initialSeconds += 60;
                  });
                },
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  // side: BorderSide(color: Colors.blue, width: 1.5),
                ),
                child: Text("+5m"),
                onPressed: () {
                  setState(() {
                    _initialSeconds += 300;
                  });
                },
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  // side: BorderSide(color: Colors.blue, width: 1.5),
                ),
                child: Text("+10m"),
                onPressed: () {
                  setState(() {
                    _initialSeconds += 600;
                  });
                },
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  // side: BorderSide(color: Colors.blue, width: 1.5),
                ),
                child: Text("+30m"),
                onPressed: () {
                  setState(() {
                    _initialSeconds += 1800;
                  });
                },
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  // side: BorderSide(color: Colors.blue, width: 1.5),
                ),
                child: Text("+1h"),
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
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            physics: const NeverScrollableScrollPhysics(),
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  // side: BorderSide(color: Colors.blue, width: 1.5),
                ),
                child: Text("Zero"),
                onPressed: () {
                  setState(() {
                    _initialSeconds = 0;
                  });
                },
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  // side: BorderSide(color: Colors.blue, width: 1.5),
                ),
                child: Text("Set"),
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
