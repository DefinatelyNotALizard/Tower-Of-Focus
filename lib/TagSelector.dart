import 'package:flutter/material.dart';
import 'package:tower_of_focus/globals.dart';

class TagSelector extends StatefulWidget {
  const TagSelector({super.key});

  @override
  State<TagSelector> createState() => _TagSelectorState();
}

class _TagSelectorState extends State<TagSelector> {
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
                    if (currentTagIndex != 0) {
                      currentTagIndex--;
                    } else {
                      currentTagIndex = tagNames.length - 1;
                    }
                    currentTag = tagNames[currentTagIndex];
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
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 60,
                  color: tagColours[currentTagIndex],
                ),
                Text(
                  tagNames[currentTagIndex].length < 7
                      ? tagNames[currentTagIndex]
                      : tagNames[currentTagIndex].substring(0, 6),
                  style: defaultText,
                )
              ],
            )),
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
                    if (currentTagIndex != tagNames.length - 1) {
                      currentTagIndex++;
                    } else {
                      currentTagIndex = 0;
                    }
                    currentTag = tagNames[currentTagIndex];
                  });
                },
              ),
            )),
        const Spacer()
      ],
    );
  }
}
