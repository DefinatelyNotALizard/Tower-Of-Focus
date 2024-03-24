import 'package:flutter/material.dart';
import 'package:tower_of_focus/globals.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
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
            child: Column(
              children: [
                Text(
                    'This is the settings page, in a later version, you will be able to modify parameters of the app to suit your preferences here. For now though, it is empty',
                    style: noticeText),
                Text('Contact the developper at: \n jacquesmlang@gmail.com \n 06 69 16 17 75',
                    style: noticeText),
                    FloatingActionButton.extended(
                  //This is the random BS button, it does whatever debugging task I set it to. it is not active in user-facing releases, even beta.
                  //At the moment, it's last function was emptying the entire saved data in SharedPreferences
                  onPressed: () {
                    dataNuke();
                  },
                  label: Text('Reset (app restart required)', style: defaultTextWhite),
                  backgroundColor: Colors.red,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
