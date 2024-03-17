import 'package:flutter/material.dart';
import 'globals.dart';
import 'dart:math';
import 'dart:async';

class FadingButton extends StatefulWidget {
  const FadingButton({super.key});

  @override
  _FadingButtonState createState() => _FadingButtonState();
}

class _FadingButtonState extends State<FadingButton> {
  late Color currentColor;
  final Random random = Random(); // Create an instance of Random
  late Timer colorChangeTimer;

  @override
  void initState() {
    super.initState();
    currentColor = getRandomColor();

    // Set up a timer to change color every 5 seconds
    colorChangeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      changeColor();
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    colorChangeTimer.cancel();
    super.dispose();
  }

  Color getRandomColor() {
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }

  void changeColor() {
    setState(() {
      currentColor = getRandomColor();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      duration: const Duration(seconds: 3),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [currentColor, getRandomColor()],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: currentColor.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          // Handle button tap (navigate to pro version, etc.)
          changeColor();
        },
        child: ListTile(
          title: Text('Get Pro Version', style: headerText),
          leading: Icon(
            Icons.star,
            color: Colors.white,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}
