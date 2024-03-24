library dyna_manager.globals;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> dataNuke() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}

Future<void> writeData(String name, List list, dynamic data, String type) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (type == 'int') {
    list.insert(0, data);
    List<String> intStringList = list.map((intNumber) => intNumber.toString()).toList();
    prefs.setStringList(name, intStringList.map((e) => e.toString()).toList());
  } else if (type == 'col') {
    list.insert(0, data);
    List<String> hexStringList = list.map((color) => color.value.toRadixString(16)).toList().cast<String>();
    prefs.setStringList(name, hexStringList.map((e) => e.toString()).toList());
  } else {
    list.insert(0, data);
    prefs.setStringList(name, list.map((e) => e.toString()).toList());
  }
}


Future<void> removeData(String name, List list, int index) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  list.removeAt(index);
  await prefs.remove(name);
  prefs.setStringList(name, list.map((e) => e.toString()).toList());
}

Future<void> replaceData(String name, List list, dynamic data, String type, int index) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (type == 'col'){
    list[index] = data;
    List<String> hexStringList = list.map((color) => color.value.toRadixString(16)).toList().cast<String>();
    await prefs.remove(name);
    prefs.setStringList(name, hexStringList.map((e) => e.toString()).toList());
  }else{
    list[index] = data;
    await prefs.remove(name);
    prefs.setStringList(name, list.map((e) => e.toString()).toList());
  }
  
  
}

Future<void> saveIntToSharedPreferences(String key, int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt(key, value);
}


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

List<String> towerTypes = ['assets/clay_tower.png', 'assets/stone_tower.png'];
//History
List<String> towerTypePaths = [];
List<String> tagsUsed = [];

List<int> timeHistory = [];

List<String> days = [];

int currentTowerTypeIndex = 0;

String currentTowerAssetPath = 'assets/clay_tower.png';

List<int> times = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120];

int currentTimeIndex = 0;

int currentTime = times[0];

//String sectionInProgress = currentTowerAssetPath;

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


int savedTime = 0;