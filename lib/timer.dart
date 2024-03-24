import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:tower_of_focus/globals.dart';

class MyTimer extends StatefulWidget {
  final GlobalKey<MyTimerState> timerKey = GlobalKey<MyTimerState>();
  final VoidCallback onTimerFinished;
  MyTimer({super.key, required this.onTimerFinished});

  @override
  MyTimerState createState() => MyTimerState();
}

class MyTimerState extends State<MyTimer> {
  int _seconds = currentTime * 60; // Initial timer value in seconds
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_seconds == 0) {
          _timer.cancel();
          for (var i = 0; i < currentTime / 10; i++) {
            writeData('towerTypePaths', towerTypePaths, currentTowerAssetPath, 'st');
            //towerTypePaths.insert(0, currentTowerAssetPath);
          }
          writeData('tagsUsed', tagsUsed, currentTag, 'st');
          writeData('timeHistory', timeHistory, currentTime, 'int');
          writeData('days', days, DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now()), 'st');
          //tagsUsed.insert(0, currentTag);
          //timeHistory.insert(0, currentTime);
          //days.insert(0, DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now()));
          currentReward = currentTime;
          widget.onTimerFinished(); // Call the callback
        } else {
          setState(() {
            _seconds--;
          });
        }
      },
    );
  }

  void stopTimer() {
    _timer.cancel();
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200,
        height: 200,
        child: Center(
          child: Text(
            _formatTime(_seconds),
            style: timerText,
          ),
        ));
  }
}
