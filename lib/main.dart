import 'package:flutter/material.dart';
import 'package:tower_of_focus/SettingsPage.dart';
import 'package:tower_of_focus/StatsPage.dart';
import 'package:tower_of_focus/TagsPage.dart';
import 'package:tower_of_focus/AcheivementsPage.dart';
import 'package:tower_of_focus/ShopPage.dart';
import 'package:tower_of_focus/globals.dart';
import 'package:tower_of_focus/towerlist.dart';
import 'pro.dart';
import 'TowerSelector.dart';
import 'TimeSelector.dart';
import 'TagSelector.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'globals.dart';
//List of variables/lists to load:
//towerTypePaths
//tagsUsed
//timeHistory
//days
//tagNames
//tagColours



Future<void> loadData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  towerTypePaths = prefs.getStringList('towerTypePaths') ?? [];
  tagsUsed = prefs.getStringList('tagsUsed') ?? [];
  timeHistory = prefs.getStringList('timeHistory')?.map((e) => int.parse(e)).toList() ?? [];
  days = prefs.getStringList('days') ?? [];
  tagNames = prefs.getStringList('tagNames') ?? [];
  
  // Loading an integer value
  money = prefs.getInt('money') ?? 0; 
  
  // Loading tagColours as a list of integers and converting them back to Color objects
  tagColours = prefs.getStringList('tagColours')?.map((colorValue) {
    return Color(int.parse(colorValue, radix: 16)); // Parse hexadecimal string to integer
  }).toList() ?? [];
}




//Just noticed that while browsing through the app, if the timer has been started, it will reset if you leave the homepage, decided this isn't a bug, it's now a feature to stop you getting distracted
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  loadData();
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      
    });
    return const TowerOfFocus(/*onRefresh: () {
      setState(() {});
    }*/
        );
  }
}

class TowerOfFocus extends StatefulWidget {
  const TowerOfFocus({super.key});

  //final VoidCallback onRefresh;
  // const TowerOfFocus({Key? key, required this.onRefresh}) : super(key: key);

  @override
  State<TowerOfFocus> createState() => TowerOfFocusState();
}

class TowerOfFocusState extends State<TowerOfFocus> {
  List<Widget> _mainContainerOptions = [];
  @override
  void initState() {
    super.initState();

    _mainContainerOptions = [
      Container(
        color: Colors.lightBlue,
        child: Row(
          children: [
            const Spacer(),
            SizedBox(
              width: 300,
              child: TowerList(
                onRefresh: () {
                  setState(() {
                    // Refresh logic here
                    currentReward = 0;
                  });
                },
              ),
            ),
            const Spacer()
          ],
        ),
      ),
      const TagsPage(),
      const AcheivementsPage(),
      const ShopPage(),
      const StatsPage(),
      const SettingsPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: Colors.lightBlue,
        key: scaffoldKey,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.menu, size: 40),
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
          ),
          title: SizedBox(
            // Remove the width property to allow flexible width
            // width: 500,
            height: 500,
            child: Row(
              children: [
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(0),
                  width: 120,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          const Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.blueGrey,
                            ),
                            margin: const EdgeInsets.fromLTRB(0, 7, 0, 0),
                            height: 35,
                            width: 100,
                            child: Row(
                              children: [
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  child: Text('$money', style: footerText),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            //color: Colors.green,
                            margin: const EdgeInsets.all(0),
                            child: Image.asset(
                              'assets/coin.png',
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Container(
          color: Colors.lightBlue,
          child: _mainContainerOptions[currentPage],
        ),
         drawer: Drawer(
          child: Container(
            color: Colors.white,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  height: 95,
                  child: DrawerHeader(
                    //padding: EdgeInsets.fromLTRB(10, 00, 10, 10),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Text('Tower of Focus', style: headerText),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.apartment,
                    color: Colors.black,
                    size: iconSize,
                  ),
                  title: Text('Tower', style: defaultText),
                  onTap: () {
                    setState(() {
                      currentPage = 0;
                    });
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.sell,
                    color: Colors.black,
                    size: iconSize,
                  ),
                  title: Text('Tags', style: defaultText),
                  onTap: () {
                    setState(() {
                      currentPage = 1;
                    });
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.military_tech,
                    color: Colors.black,
                    size: iconSize,
                  ),
                  title: Text('Achievements', style: defaultText),
                  onTap: () {
                    setState(() {
                      currentPage = 2;
                    });
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.shop_2,
                    color: Colors.black,
                    size: iconSize,
                  ),
                  title: Text('Shop', style: defaultText),
                  onTap: () {
                    setState(() {
                      currentPage = 3;
                    });
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.trending_up,
                    color: Colors.black,
                    size: iconSize,
                  ),
                  title: Text('Stats', style: defaultText),
                  onTap: () {
                    setState(() {
                      selectedIndexStats = 0;
                      currentPage = 4;
                    });
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: Colors.black,
                    size: iconSize,
                  ),
                  title: Text('Settings', style: defaultText),
                  onTap: () {
                    setState(() {
                      currentPage = 5;
                    });
                  },
                ),

                const FadingButton(),
                Container(
                  height: 50,
                  color: Colors.white,
                ),
                Text('BETA:0.0.4', style: noticeText),

                // Add more ListTile items as needed
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/* class VaryingPage extends StatefulWidget {
  const VaryingPage({Key? key}) : super(key: key);

  @override
  State<VaryingPage> createState() => _VaryingPageState();
}

class _VaryingPageState extends State<VaryingPage> {
  List<Widget> _mainContainerOptions = <Widget>[
    Container(
      color: Colors.lightBlue,
      child: Row(
          children: [
            Spacer(),
            Container(
              width: 300,
              child: TowerList(
              ),
            ),
            Spacer()
          ],
        ),
    ),
    TagsPage(),
    AcheivementsPage(),
    ShopPage(),
    StatsPage(),
    SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return _mainContainerOptions[currentPage];
  }
} */

Future<bool> showTheBottomSheet(BuildContext context) async {
  Completer<bool> completer = Completer<bool>();

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      double sheetHeight = MediaQuery.of(context).size.height * 0.5;

      return Container(
        height: sheetHeight,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 8,
              width: 80,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            Container(
              child: const TowerSelector(),
            ),
            Container(
              child: const TimeSelector(),
            ),
            Container(
              child: tagNames.isEmpty
                      ? Text('Tag list empty', style: footerText,)
                      :const TagSelector()
            ),
            tagNames.isEmpty
                      ? const SizedBox(
                        height: 10,
                        width: 10,
                      )
                      :ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  elevation: 0, // Set elevation to 0
                  shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                ),
              child: Text('Go', style: defaultTextWhite),
              onPressed: () {
              
                //sectionInProgress = currentTowerAssetPath;
                countdown = true;
                goTime = true;
                savedTime = 0;
                Navigator.pop(context);
                completer.complete(true);
              },
            ),
            
          ],
        ),
      );
    },
  );

  return completer.future;
}
