import 'package:flutter/material.dart';
import 'package:tower_of_focus/globals.dart';

class TowerSelector extends StatefulWidget {
  const TowerSelector({super.key});

  @override
  State<TowerSelector> createState() => _TowerSelectorState();
}

class _TowerSelectorState extends State<TowerSelector> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Container(
            margin: const EdgeInsets.all(10),
            child: Center(
              child: ElevatedButton(
                
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  elevation: 0, // Set elevation to 0
                  shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                ),
                child: const SizedBox(
                  height: 60,
                  width: 20,
                  child: Icon(Icons.arrow_back_ios, size: 30, color: Colors.white,),
                ),
                onPressed: () {
                  setState(() {
                    if (currentTowerTypeIndex != 0) {
                      currentTowerTypeIndex--;
                      currentTowerAssetPath = towerTypes[currentTowerTypeIndex];
                    } else {
                      currentTowerTypeIndex = towerTypes.length - 1;
                      currentTowerAssetPath = towerTypes[currentTowerTypeIndex];
                    }
                  });
                },
              ),
            )),
        Container(
          decoration: BoxDecoration(
            color: Colors.white, // Set the background color
            borderRadius: BorderRadius.circular(5), // Set the border radius
          ),
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          height: 60,
          width: 100,
          child: Image.asset(
            currentTowerAssetPath, // Replace with your actual image path
            width: 45, // Adjust width as needed
            height: 45, // Adjust height as needed
            fit: BoxFit.contain, // Adjust fit as needed
          ),
        ),
        Container(
            margin: const EdgeInsets.all(10),
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  elevation: 0, // Set elevation to 0
                  shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                ),
                child: const SizedBox(
                  height: 60,
                  width: 20,
                  child: Icon(Icons.arrow_forward_ios, size: 30, color: Colors.white,),
                ),
                onPressed: () {
                  setState(() {
                    if (currentTowerTypeIndex != towerTypes.length - 1) {
                      currentTowerTypeIndex++;
                      currentTowerAssetPath = towerTypes[currentTowerTypeIndex];
                    } else {
                      currentTowerTypeIndex = 0;
                      currentTowerAssetPath = towerTypes[currentTowerTypeIndex];
                    }
                  });
                },
              ),
            )),
        const Spacer()
      ],
    );
  }
}
