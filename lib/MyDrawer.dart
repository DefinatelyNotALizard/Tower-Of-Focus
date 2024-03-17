import 'package:flutter/material.dart';
import 'package:tower_of_focus/globals.dart';
import 'pro.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 70,
              child: DrawerHeader(
                //padding: EdgeInsets.all(),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header', style: headerText),
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
              title: Text('Acheivements', style: defaultText),
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

            const FadingButton()
            /* ListTile(
                  title: Text('Dynamite Studios', style: footerText),
                  onTap: () {
                    // Handle item 2 tap
                  },
                ), */
            // Add more ListTile items as needed
          ],
        ),
      ),
    );
  }
}
