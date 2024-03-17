import 'package:flutter/material.dart';

class ScaffoldBlock extends StatefulWidget {
  const ScaffoldBlock({super.key});

  @override
  State<ScaffoldBlock> createState() => _ScaffoldBlockState();
}

class _ScaffoldBlockState extends State<ScaffoldBlock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'lib/assets/scaffold_clay.png', // Replace with your actual image path
        width: 200, // Adjust width as needed
        height: 200, // Adjust height as needed
        fit: BoxFit.contain, // Adjust fit as needed
      ),
    );
  }
}
