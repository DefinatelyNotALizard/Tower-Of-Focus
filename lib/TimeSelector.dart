import 'package:flutter/material.dart';
import 'package:tower_of_focus/globals.dart';

class TimeSelector extends StatefulWidget {
  const TimeSelector({super.key});

  @override
  State<TimeSelector> createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Container(
            margin: const EdgeInsets.all(10),
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  elevation: 0, // Set elevation to 0
                  shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                ),
                child: const SizedBox(
                  height: 60,
                  width: 20,
                  child: Icon(Icons.arrow_back_ios, size: 30, color: Colors.white,),
                ),
                onPressed: () {
                  setState(() {
                    if (currentTimeIndex != 0) {
                      currentTimeIndex--;
                      currentTime = times[currentTimeIndex];
                    } else {
                      currentTimeIndex = times.length - 1;
                      currentTime = times[currentTimeIndex];
                    }
                  });
                },
              ),
            )),
        Container(
            decoration: BoxDecoration(
              color: Colors.white, // Set the background color
              borderRadius: BorderRadius.circular(5), // Set the border radius
            ),
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            height: 60,
            width: 100,
            child: Center(
              child: Text(
                currentTime.toString(),
                style: selectorTextBlack,
              ),
            )),
        Container(
            margin: const EdgeInsets.all(10),
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  elevation: 0, // Set elevation to 0
                  shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                ),
                child: const SizedBox(
                  height: 60,
                  width: 20,
                  child: Icon(Icons.arrow_forward_ios, size: 30, color: Colors.white,),
                ),
                onPressed: () {
                  setState(() {
                    if (currentTimeIndex != times.length - 1) {
                      currentTimeIndex++;
                      currentTime = times[currentTimeIndex];
                    } else {
                      currentTimeIndex = 0;
                      currentTime = times[currentTimeIndex];
                    }
                  });
                },
              ),
            )),
        const Spacer()
      ],
    );
  }
}
