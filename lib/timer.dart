import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:tower_of_focus/globals.dart';
import 'package:intl/intl.dart';

DateTime now = DateTime.now();
int time = now.hour * 3600 + now.minute * 60 + now.second;



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
    if (freezeTime == 0) {
      FlutterAlarmClock.createTimer(length: _seconds);
    }
    
    _startTimer();
  }

  void _startTimer() {
    //freezeTime = time;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (freezeTime == 0) {
          freezeTime = now.hour * 3600 + now.minute * 60 + now.second;
        }
        if (_seconds <= 0) {
          _timer.cancel();
          savedTime = 0;
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
          if (currentPage != 0){
          _timer.cancel();
          }else{
            setState(() {
            _seconds = (currentTime * 60) - (time - freezeTime);
            now = DateTime.now();
            time = now.hour * 3600 + now.minute * 60 + now.second;
            savedTime = _seconds;
          });
          }
        }
      },
    );
  }

  void stopTimer() {
    
    _timer.cancel();
    savedTime = 0;
    freezeTime = 0;
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
        width: 220,
        height: 200,
        child: Center(
          child: Text(
            _formatTime(_seconds),
            style: timerText,
          ),
        ));
  }
}
