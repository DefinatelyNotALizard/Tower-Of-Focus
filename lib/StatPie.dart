import 'dart:math';
import 'package:flutter/material.dart';
import 'globals.dart';
import 'StatsPage.dart';

class PieWithHole extends StatefulWidget {
  const PieWithHole({super.key});

  @override
  _PieWithHoleState createState() => _PieWithHoleState();
}

class _PieWithHoleState extends State<PieWithHole> {
  double previousNet = 0;
  double balance = 0;
  double debt = 0;
  double investments = 0;
  double netWorth = 0;
  String numberLetters = 'k';
  String numberDisplayed = '0';
  double placeholderNumber = 1;
  Icon trend = Icon(Icons.trending_down, size: iconSize, color: Colors.yellow);

  @override
  Widget build(BuildContext context) {
    double pieSize = /*MediaQuery.of(context).size.width * 1;*/ 1;

    // Adjust the hole size as needed

    if ((MediaQuery.of(context).size.height * 0.7) >
        (MediaQuery.of(context).size.width * 0.7)) {
      pieSize = MediaQuery.of(context).size.width * 0.7;
    } else {
      pieSize = MediaQuery.of(context).size.height * 0.7;
    }
    double holeSize = pieSize * 0.7;

    int totalTime = timeHistory.reduce((value, element) => value + element);

    //Here we are going to write a small program to load the appropriate values into the data dictionnary
    //First we reinitialise the dictionary
    data.clear();
    //We will iterate over every element in the timeHistory list (see globals.dart)
    for (var i = 0; i < timeHistory.length; i++) {
      //For every element in timeHistory we will add it to the value in the data dictionnary at location key the element of tagsUsed of the same index

      data[tagsUsed[i]] = (data[tagsUsed[i]] ?? 0) + timeHistory[i];
    }
    //Here we are going to write a small program to load the appropriate values into the dataWeek dictionnary
    //First we reinitialise the dictionary
    if (selectedIndexStats == 0) {
      dataWeek.clear();
      for (var i = 0; i < datesThisWeek.length; i++) {
        dataWeek[tagsUsed[i]] = (dataWeek[tagsUsed[i]] ?? 0) +
            timeHistory[
                i]; //This line makes the pie chart use only the correct data
      }
    }
    return SizedBox(
      height: pieSize,
      width: pieSize,
      child: Stack(
        children: [
          CustomPaint(
            painter: selectedIndexStats == 0
                ? PieChartPainter(dataWeek)
                : selectedIndexStats == 1
                    ? PieChartPainter(dataMonth)
                    : PieChartPainter(data),
            size: Size(pieSize, pieSize),
          ),
          Center(
            child: Container(
              height: holeSize,
              width: holeSize,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                const Spacer(),
                Row(
                  children: [
                    const Spacer(),
                    Text(
                      selectedIndexStats == 0
                          ? '$timeBucketThisWeek'
                          : selectedIndexStats == 1
                              ? '$timeBucketThisMonth'
                              : '$totalTime',
                      style: selectorTextBlack,
                    ),
                    const Spacer()
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PieChartPainter extends CustomPainter {
  final Map<String, double> data;

  PieChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    double total = data.values.reduce((value, element) => value + element);
    double startAngle = 0;

    for (var entry in data.entries) {
      final paint = Paint()
        ..color = tagColours[
            /*data.keys.toList()*/tagNames.indexOf(entry.key) % tagColours.length]
        ..style = PaintingStyle.fill;

      final sweepAngle = (entry.value / total) * 360;
      canvas.drawArc(
        Rect.fromCenter(
          center: size.center(Offset.zero),
          width: size.width,
          height: size.height,
        ),
        radians(startAngle),
        radians(sweepAngle),
        true,
        paint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  double radians(double degrees) {
    return degrees * pi / 180;
  }
}
