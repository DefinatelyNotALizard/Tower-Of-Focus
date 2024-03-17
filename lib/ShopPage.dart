import 'package:flutter/material.dart';
import 'package:tower_of_focus/globals.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // This container fills the space under the appBar
          height: 56,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
        ),
        Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 56,
            child: Text(
                'This is the shop page, in a later version, you will be able to purchase items and upgrades here. For now though, it is empty',
                style: noticeText))
      ],
    );
  }
}
