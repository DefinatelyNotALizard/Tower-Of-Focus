import 'package:flutter/material.dart';
import 'package:tower_of_focus/globals.dart';
import 'package:tower_of_focus/scaffoldBlock.dart';
import 'package:tower_of_focus/towerblock.dart';
import 'timer.dart';
import 'main.dart';
import 'package:audioplayers/audioplayers.dart';

class TowerList extends StatefulWidget {
  //TowerList({Key? key}) : super(key: key);
  final GlobalKey<MyTimerState> timerKey = GlobalKey();
  final VoidCallback onRefresh;
  TowerList({super.key, required this.onRefresh});

  @override
  State createState() => TowerListState();
}

class TowerListState extends State<TowerList> {
  final player = AudioPlayer();
  AudioPlayer audioPlayer = AudioPlayer();

  Future<void> playSound() async {
    String soundPath =
        "audio/rickroll.mp3"; //You don't need to include assets/ because AssetSource assume that you have sound in your assets folder.
    await player.setVolume(1.0); // Set volume to maximum (1.0)
    await player.play(AssetSource(soundPath));
    //await player.setSourceUrl('hrrps://widgetwisom/sound1.wav');
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: countdown == false ? towerTypePaths.length + 2 : 3,
      itemBuilder: (BuildContext context, int index) {
        if (index == 1) {
          if (countdown == false) {
            return Stack(
              children: [
                const Row(
                  children: [Spacer(), ScaffoldBlock(), Spacer()],
                ),
                Center(
                  child: SizedBox(
                    width: 180,
                    height: 60,
                    child: FloatingActionButton.extended(
                      onPressed: () async {
                        goTime = false;
                        countdown = false;

                        bool result = await showTheBottomSheet(context);
                        setState(() {
                          countdown = result;
                        });
                      },
                      label: Text('Build', style: headerText),
                      backgroundColor: Colors.green,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Stack(
              children: [
                const Row(
                  children: [Spacer(), ScaffoldBlock(), Spacer()],
                ),
                Center(
                  child: SizedBox(
                    width: 180,
                    height: 60,
                    child: FloatingActionButton.extended(
                      onPressed: () async {
                        setState(() {
                          goTime = false;
                          countdown = false;

                          widget.timerKey.currentState?.stopTimer();
                        });
                      },
                      label: Text('Cancel', style: headerText),
                      backgroundColor: Colors.red,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        } else if (index == 0) {
          if (countdown == true) {
            return MyTimer(
              key: widget.timerKey,
              onTimerFinished: () {
                playSound();
                // Callback function triggered when timer finishes
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: LayoutBuilder(builder: (context, constraints) {
                          return Container(
                            height: 400,
                            padding: const EdgeInsets.all(7.5),
                            child: Column(
                              children: [
                                Text('Congratulations!',
                                    style: headerTextBlack),
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  height: 100,
                                  width: 100,
                                  child: const TowerBlock(),
                                ),
                                Text('You focused for $currentTime minutes',
                                    style: defaultText),
                                Text('You earned $currentReward coins',
                                    style: defaultText),
                                FloatingActionButton.extended(
                                  onPressed: () {
                                    currentReward = 0;
                                    widget.onRefresh();
                                    Navigator.pop(context);
                                  },
                                  label: Text('OK', style: headerText),
                                  backgroundColor: Colors.blue,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                      );
                    });
                setState(() {
                  money += currentReward * 100;

                  countdown = false;
                  goTime = false;
                  // Trigger a refresh of the TowerList
                });
              },
            );
          } else {
            return Container(
              height: 200,
            );
          }
        } else {
          return Container(
            child: Image.asset(
              towerTypePaths[index - 2], // Replace with your actual image path
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
          );
        }
      },
    );
  }
}
