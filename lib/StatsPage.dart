
import 'package:flutter/material.dart';
import 'package:tower_of_focus/globals.dart';
import 'StatPie.dart';
import 'package:intl/intl.dart';

int timeBucketThisWeek =
    0; //This needs to be accessible globally because it is used to display the number in the centre of the pie chart by StatPie.dart
int timeBucketThisMonth = 0; //Same here
DateTime now = DateTime
    .now(); //This is used in several different places in this file ansd i thought I might end up using it elsewhere
String currentDay = DateFormat('dd-MM-yyyy').format(DateTime.now());
List<String> datesThisWeek = [];

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    //Now we need to write a program that will grab all the times from today and add them up
    //First we get the current day

    //We then initialise a "bucket" in which to add up our times
    int timeBucketToday = 0;
    //Now for each item in days we check the first ten characters, which coresponds to the date
    // Set all values to zero
    dataWeek.forEach((key, value) {
      dataWeek[key] = 0;
    });

    for (var i = 0; i < days.length; i++) {
      if (days[i].substring(0, 10) == currentDay) {
        timeBucketToday += timeHistory[i];
        dataWeek[tagsUsed[i]] = (dataWeek[tagsUsed[i]] ?? 0) +
            timeHistory[
                i]; //This line makes the pie chart use only the correct data
      }
    }

    //
    //Now that's done, we want the average daily focus time for this week
    //we start by filtering the list days and keeping any element that matches the current week
    datesThisWeek.clear();
    List<int> indicesThisWeek = [];
    int today = 0;
    void filterDatesForCurrentWeek(List<String> allDates) {
      today = now.weekday;
      DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
      DateTime endOfWeek = now.add(Duration(days: 7 - now.weekday));

      for (int i = 0; i < allDates.length; i++) {
        String date = allDates[i];
        DateTime currentDate = DateFormat('dd-MM-yyyy HH:mm').parse(date);

        if ((currentDate.isAfter(startOfWeek) ||
                currentDate.day == startOfWeek.day) &&
            (currentDate.isBefore(endOfWeek) ||
                currentDate.day == endOfWeek.day)) {
          datesThisWeek.add(date);
          indicesThisWeek.add(i);
        }
      }
    }

    filterDatesForCurrentWeek(days);
    //Now we create another bucket for this week

    //We then grab the items in the timeHistory that are located by the indicies in the indicesThisWeek list
    timeBucketThisWeek = 0;
    // Set all values to zero
    /*dataMonth.forEach((key, value) {
      dataMonth[key] = 0;
    });*/
    dataMonth.clear();

    for (var i = 0; i < indicesThisWeek.length; i++) {
      timeBucketThisWeek += timeHistory[indicesThisWeek[i]];

      dataWeek[tagsUsed[i]] = (dataWeek[tagsUsed[i]] ?? 0) +
          timeHistory[
              i]; //This line makes the pie chart use only the correct data
    }
    //Now we divide by seven ton get the daily average
    int dailyAverage = timeBucketThisWeek ~/ today;

    //Next we want the dates in the list that are in the current month
    List<String> datesThisMonth = [];
    List<int> indicesThisMonth = [];

    void filterDatesForCurrentMonth(List<String> allDates) {
      DateTime startOfMonth = DateTime(now.year, now.month, 1);
      DateTime endOfMonth =
          DateTime(now.year, now.month + 1, 1).subtract(const Duration(days: 1));

      for (int i = 0; i < allDates.length; i++) {
        String date = allDates[i];
        DateTime currentDate = DateFormat('dd-MM-yyyy HH:mm').parse(date);

        if (currentDate.isAfter(startOfMonth) &&
            currentDate.isBefore(endOfMonth)) {
          datesThisMonth.add(date);
          indicesThisMonth.add(i);
        }
      }
    }

    filterDatesForCurrentMonth(days);
    //We then grab the items in the timeHistory that are located by the indicies in the indicesThisWeek list
    for (var i = 0; i < indicesThisMonth.length; i++) {
      timeBucketThisMonth += timeHistory[indicesThisMonth[i]];
      dataMonth[tagsUsed[i]] = (dataMonth[tagsUsed[i]] ?? 0) +
          timeHistory[
              i]; //This line makes the pie chart use only the correct data
    }
    //Now we divide by the days passed ton get the daily average
    int dailyAverageThisMonth = timeBucketThisMonth ~/ now.day;
    return Column(
      children: [
        Container(
          // This container fills the space under the appBar
          height: 80,
          width: MediaQuery.of(context).size.width,
          color: Colors.lightBlue,
        ),
        Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 80,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                  color: Colors.white,
                  child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(5),
                      /* width: MediaQuery.of(context).size.width *
                          widthMultiplier *
                          0.4, */
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 10, 0, 40),
                            child: Row(
                              children: [
                                const Spacer(),
                                FilledButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedIndexStats = 0;
                                        timeBucketThisWeek = 0;
                                        timeBucketThisMonth = 0;
                                      });
                                    },
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                8.0), // Adjust the border radius as needed
                                          ),
                                        ),
                                        padding: MaterialStateProperty.all<
                                                EdgeInsetsGeometry?>(
                                            const EdgeInsets.all(15.0)),
                                        backgroundColor: selectedIndexStats == 0
                                            ? MaterialStateProperty.all<Color?>(
                                                Colors.blue)
                                            : MaterialStateProperty.all<Color?>(
                                                Colors.white)),
                                    child: Text('This week',
                                        style: selectedIndexStats == 0
                                            ? segButtonTextSelected
                                            : segButtonText)),
                                FilledButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedIndexStats = 1;
                                        timeBucketThisWeek = 0;
                                        timeBucketThisMonth = 0;
                                      });
                                    },
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                8.0), // Adjust the border radius as needed
                                          ),
                                        ),
                                        padding: MaterialStateProperty.all<
                                                EdgeInsetsGeometry?>(
                                            const EdgeInsets.all(15.0)),
                                        backgroundColor: selectedIndexStats == 1
                                            ? MaterialStateProperty.all<Color?>(
                                                Colors.blue)
                                            : MaterialStateProperty.all<Color?>(
                                                Colors.white)),
                                    child: Text('This month',
                                        style: selectedIndexStats == 1
                                            ? segButtonTextSelected
                                            : segButtonText)),
                                FilledButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedIndexStats = 2;
                                        timeBucketThisWeek = 0;
                                        timeBucketThisMonth = 0;
                                      });
                                    },
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                8.0), // Adjust the border radius as needed
                                          ),
                                        ),
                                        padding: MaterialStateProperty.all<
                                                EdgeInsetsGeometry?>(
                                            const EdgeInsets.all(15.0)),
                                        backgroundColor: selectedIndexStats == 2
                                            ? MaterialStateProperty.all<Color?>(
                                                Colors.blue)
                                            : MaterialStateProperty.all<Color?>(
                                                Colors.white)),
                                    child: Text('This year',
                                        style: selectedIndexStats == 2
                                            ? segButtonTextSelected
                                            : segButtonText)),
                                const Spacer()
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              selectedIndexStats == 0
                                  ? timeBucketThisWeek == 0
                                      ? Text('Nope', style: defaultText)
                                      : const PieWithHole()
                                  : selectedIndexStats == 1
                                      ? timeBucketThisMonth == 0
                                          ? Text('Nope', style: defaultText)
                                          : const PieWithHole()
                                      : selectedIndexStats == 2
                                          ? days.isEmpty
                                              ? Text('Nope', style: defaultText)
                                              : const PieWithHole()
                                          : Text(
                                              'If you see this text, contact the developper, this is a bug',
                                              style: footerText),
                              const Spacer(),
                            ],
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                padding: const EdgeInsets.all(10),
                                child: Column(children: [
                                  Text('Daily average:', style: footerText),
                                  Text(
                                    selectedIndexStats == 0
                                        ? '$dailyAverage'
                                        : selectedIndexStats == 1
                                            ? '$dailyAverageThisMonth'
                                            : '-',
                                    style: headerTextBlack,
                                  )
                                ]),
                              ),
                              const Spacer(),
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                padding: const EdgeInsets.all(10),
                                child: Column(children: [
                                  Text("Today's total:", style: footerText),
                                  Text(
                                    selectedIndexStats == 0
                                        ? '$timeBucketToday'
                                        : selectedIndexStats == 1
                                            ? '$timeBucketThisMonth'
                                            : '-',
                                    style: headerTextBlack,
                                  )
                                ]),
                              ),
                              const Spacer()
                            ],
                          )
                        ],
                      ))),
            ))
      ],
    );
  }
}
