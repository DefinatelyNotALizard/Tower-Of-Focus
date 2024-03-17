library dyna_manager.globals;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const String alarmPath = 'assets/audio/sample.mp3';

double sizeMultiplier = 1;

int currentPage = 0;
int selectedIndexStats = 0;

bool countdown = false;
bool goTime = false;

double fontSize = 23;
double iconSize = 25;

TextStyle defaultText = GoogleFonts.roboto(
  color: Colors.black,
  fontSize: fontSize,
  fontWeight: FontWeight.normal,
);
TextStyle defaultTextWhite = GoogleFonts.roboto(
  color: Colors.white,
  fontSize: fontSize,
  fontWeight: FontWeight.normal,
);
TextStyle headerText = GoogleFonts.roboto(
  color: Colors.white,
  fontSize: fontSize * 1.1,
  fontWeight: FontWeight.normal,
);
TextStyle timerText = GoogleFonts.roboto(
  color: Colors.white,
  fontSize: fontSize * 3.5,
  fontWeight: FontWeight.normal,
);
TextStyle headerTextBlack = GoogleFonts.roboto(
  color: Colors.black,
  fontSize: fontSize * 1.1,
  fontWeight: FontWeight.normal,
);
TextStyle selectorTextBlack = GoogleFonts.roboto(
  color: Colors.black,
  fontSize: fontSize * 1.5,
  fontWeight: FontWeight.normal,
);
TextStyle footerText = GoogleFonts.roboto(
  color: Colors.grey,
  fontSize: fontSize * 0.75,
  fontWeight: FontWeight.normal,
);
TextStyle segButtonTextSelected = GoogleFonts.roboto(
  color: Colors.black,
  fontSize: fontSize * 0.7,
  fontWeight: FontWeight.normal,
);
TextStyle segButtonText = GoogleFonts.roboto(
  color: Colors.grey,
  fontSize: fontSize * 0.7,
  fontWeight: FontWeight.normal,
);
TextStyle noticeText = GoogleFonts.roboto(
  color: const Color(0xffff1100),
  fontSize: fontSize * 1,
  fontWeight: FontWeight.normal,
);

List towerTypes = ['lib/assets/clay_tower.png', 'lib/assets/stone_tower.png'];
//History
List towerTypePaths = [
  'lib/assets/clay_tower.png',
  'lib/assets/clay_tower.png',
  'lib/assets/clay_tower.png',
  'lib/assets/clay_tower.png',
  'lib/assets/clay_tower.png',
  'lib/assets/clay_tower.png',
  'lib/assets/stone_tower.png'
];
List tagsUsed = [
  'Study', //Week: 20, Month: 30, Year: 70
  'Work', //Week:15, Month: 15, Year: 15
  'Study',
  'Exercise', //Week:0, Month: 55, Year: 55
  'Exercise',
  'Study',
  'Study'
];

List<int> timeHistory = [10, 15, 10, 20, 35, 10, 40];

List<String> days = [
  '26-02-2024 10:16',
  '26-02-2024 10:16',
  '26-02-2024 10:16',
  '22-02-2024 10:16',
  '20-02-2024 10:16',
  '15-02-2024 10:16',
  '25-01-2024 10:16'
];

int currentTowerTypeIndex = 0;

String currentTowerAssetPath = 'lib/assets/clay_tower.png';

List<int> times = [1, 10, 15, 20, 25, 30, 35, 40];

int currentTimeIndex = 0;

int currentTime = times[0];

String sectionInProgress = currentTowerAssetPath;

int currentReward = 0;

int money = 0;

List<String> tagNames = ['Study', 'Work', 'Exercise'];

List<Color> tagColours = [
  Colors.red,
  Colors.green,
  Colors.blue,
];

int currentTagIndex = 0;
String currentTag = tagNames[currentTagIndex];

Map<String, double> data = {
  'Study': 0, //Red
  'Work': 0, //Green
  'Exercise': 0, //Blue
  //'GoGoGadgetD': 0,
  // Other categories...
};
Map<String, double> dataWeek = {
  'Study': 0, //Red
  'Work': 0, //Green
  'Exercise': 0, //Blue
  //'GoGoGadgetD': 0,
  // Other categories...
};
Map<String, double> dataMonth = {
  'Study': 0, //Red
  'Work': 0, //Green
  'Exercise': 0, //Blue
  //'GoGoGadgetD': 0,
  // Other categories...
};
