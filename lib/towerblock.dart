import 'package:flutter/material.dart';
import 'package:tower_of_focus/globals.dart';

class TowerBlock extends StatefulWidget {
  const TowerBlock({super.key});

  @override
  State<TowerBlock> createState() => _TowerBlockState();
}

class _TowerBlockState extends State<TowerBlock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        currentTowerAssetPath, // Replace with your actual image path
        width: 200, // Adjust width as needed
        height: 200, // Adjust height as needed
        fit: BoxFit.contain, // Adjust fit as needed
      ),
    );
  }
}
