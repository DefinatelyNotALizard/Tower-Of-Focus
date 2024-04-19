import 'dart:async';
//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:tower_of_focus/globals.dart';

int tagProcessingIndex = 0;
Color tagColour = Colors.red;

class TagsPage extends StatefulWidget {
  const TagsPage({super.key});

  @override
  State<TagsPage> createState() => _TagsPageState();
}

class _TagsPageState extends State<TagsPage> {
  
  Future<bool> showTagModBottomSheet(BuildContext context, index) async {
    Completer<bool> completer = Completer<bool>();
    tagProcessingIndex = index;

    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => TagSheet(
        onUpdate: (String newName, Color newColor, int active) {
          if (active == 1) {
            setState(() {
            replaceData('tagNames', tagNames, newName, 'st', tagProcessingIndex);
            //tagNames[tagProcessingIndex] = newName;
            replaceData('tagColours', tagColours, newColor, 'col', tagProcessingIndex);
            //tagColours[tagProcessingIndex] = newColor;

          });
          }else{
            setState(() {

          });
          }
          Navigator.pop(context);
          completer.complete(true);
        },
      ),
    );

    return completer.future;
  }

  Future<bool> showTagsBottomSheet(BuildContext context) async {
    Completer<bool> completer = Completer<bool>();

    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => TagSheetCreate(
        onCreation: (String newName, Color newColor) {
          setState(() {
            writeData('tagNames', tagNames, newName, 'st');
            //tagNames.add(newName);
            writeData('tagColours', tagColours, newColor, 'col');
            //tagColours.add(tagColour);
            data.putIfAbsent(newName, () => 0);
          });
          Navigator.pop(context);
          completer.complete(true);
        },
      ),
    );

    return completer.future;
  }

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
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: Text(
                    'Tags',
                    style: headerTextBlack,
                  ),
                ),
                Expanded(

                  child:  tagNames.isEmpty
                            ? const Spacer()
                            : ListView.builder(
                      padding: EdgeInsets.zero,
                      //shrinkWrap: true,
                      itemCount: tagNames.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                            padding: const EdgeInsets.all(5),
                            child: Material(
                              elevation: 5,
                              child: Container(
                                child: ListTile(
                                  tileColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(1.0),
                                  ),
                                  title: Text(
                                    tagNames[index],
                                    style: defaultText,
                                  ),
                                  textColor: Colors.black,
                                  trailing: Container(
                                    width:
                                        30, // Set the width to create a circular container
                                    height:
                                        30, // Set the height to be the same as the width
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),

                                      color: tagColours[
                                          index], // Set the color of the circle
                                    ),
                                  ),
                                  onLongPress: () /*async*/ {
                                    //await
                                    showTagModBottomSheet(context, index);
                                  },
                                ),
                              ),
                            ));
                      }),


                ),
                //Spacer(),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      const Spacer(),
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: FloatingActionButton.extended(
                            onPressed: () async {
                              showTagsBottomSheet(context);
                            },
                            label: Text('New', style: headerText),
                            backgroundColor: Colors.blue,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                          )),
                      const Spacer(),
                    ],
                  ),
                )
              ],
            ))
      ],
    );
  }
}

class TagSheet extends StatefulWidget {
  final Function(String, Color, int) onUpdate;

  const TagSheet({super.key, required this.onUpdate});

  @override
  State<TagSheet> createState() => _TagSheetState();
}

class _TagSheetState extends State<TagSheet> {
  final TextEditingController _textEditingController = TextEditingController();
  double blockSize = 39.5;
  int colourIndex = 0;
  

  @override
  Widget build(BuildContext context) {
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
          const Text("Modify tag"),
          TextField(
            style: defaultText,
            controller: _textEditingController,
            decoration: InputDecoration(
                filled: true,
                fillColor:
                    Colors.grey, // Change this to your desired background color
                hintText: tagNames[tagProcessingIndex],
                hintStyle: defaultText),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          tagColour = Colors.red;
                          colourIndex = 0;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        width: blockSize,
                        height: blockSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.red,
                          border: Border.all(
                            color: colourIndex == 0
                                ? Colors
                                    .blueAccent // Change this to your desired outline color
                                : Colors
                                    .transparent, // No outline for other cases
                            width:
                                5.0, // Adjust the width of the outline as needed
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        tagColour = Colors.green;
                        setState(() {
                          colourIndex = 1;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        width: blockSize,
                        height: blockSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.green,
                          border: Border.all(
                            color: colourIndex == 1
                                ? Colors
                                    .blueAccent // Change this to your desired outline color
                                : Colors
                                    .transparent, // No outline for other cases
                            width:
                                5.0, // Adjust the width of the outline as needed
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        tagColour = Colors.blue;
                        setState(() {
                          colourIndex = 2;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        width: blockSize,
                        height: blockSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.blue,
                          border: Border.all(
                            color: colourIndex == 2
                                ? Colors.blue
                                    .shade700 // Change this to your desired outline color
                                : Colors
                                    .transparent, // No outline for other cases
                            width:
                                5.0, // Adjust the width of the outline as needed
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        tagColour = Colors.yellow;
                        setState(() {
                          colourIndex = 3;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        width: blockSize,
                        height: blockSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.yellow,
                          border: Border.all(
                            color: colourIndex == 3
                                ? Colors
                                    .blueAccent // Change this to your desired outline color
                                : Colors
                                    .transparent, // No outline for other cases
                            width:
                                5.0, // Adjust the width of the outline as needed
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        tagColour = Colors.purple;
                        setState(() {
                          colourIndex = 4;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        width: blockSize,
                        height: blockSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.purple,
                          border: Border.all(
                            color: colourIndex == 4
                                ? Colors
                                    .blueAccent // Change this to your desired outline color
                                : Colors
                                    .transparent, // No outline for other cases
                            width:
                                5.0, // Adjust the width of the outline as needed
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        tagColour = Colors.orange;
                        setState(() {
                          colourIndex = 5;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        width: blockSize,
                        height: blockSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.orange,
                          border: Border.all(
                            color: colourIndex == 5
                                ? Colors
                                    .blueAccent // Change this to your desired outline color
                                : Colors
                                    .transparent, // No outline for other cases
                            width:
                                5.0, // Adjust the width of the outline as needed
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        tagColour = Colors.black;
                        setState(() {
                          colourIndex = 6;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        width: blockSize,
                        height: blockSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.black,
                          border: Border.all(
                            color: colourIndex == 6
                                ? Colors
                                    .blueAccent // Change this to your desired outline color
                                : Colors
                                    .transparent, // No outline for other cases
                            width:
                                5.0, // Adjust the width of the outline as needed
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          tagColour = Colors.brown;
                          colourIndex = 7;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        width: blockSize,
                        height: blockSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.brown,
                          border: Border.all(
                            color: colourIndex == 7
                                ? Colors
                                    .blueAccent // Change this to your desired outline color
                                : Colors
                                    .transparent, // No outline for other cases
                            width:
                                5.0, // Adjust the width of the outline as needed
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Row(
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(10),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    removeData('tagNames', tagNames, tagProcessingIndex);
                    //tagNames.removeAt(tagProcessingIndex);
                    removeData('tagColours', tagColours, tagProcessingIndex);
                    //tagColours.removeAt(tagProcessingIndex);
                    widget.onUpdate('nope', tagColour, 0);
                    
                  },
                  label: Text('Delete', style: headerText),
                  backgroundColor: Colors.red,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      String text = _textEditingController.text
                          .trim(); // Remove leading and trailing whitespaces

                      if (text.isEmpty) {
                        // Set a default value when the user enters nothing
                        text = tagNames[tagProcessingIndex];
                      }

                      widget.onUpdate(text, tagColour, 1);
                      tagColour = Colors.red;
                    },
                    label: Text(' Save ', style: headerText),
                    backgroundColor: Colors.green,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                  )),
              const Spacer()
            ],
          ),
        ],
      ),
    );
  }
}

class TagSheetCreate extends StatefulWidget {
  final Function(String, Color) onCreation;

  const TagSheetCreate({super.key, required this.onCreation});

  @override
  State<TagSheetCreate> createState() => _TagSheetCreateState();
}

class _TagSheetCreateState extends State<TagSheetCreate> {
  final TextEditingController _textEditingController = TextEditingController();
  double blockSize = 39.5;
  int colourIndex = 0;
  

  @override
  Widget build(BuildContext context) {
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
          const Text("Create tag"),
          TextField(
            style: defaultText,
            controller: _textEditingController,
            decoration: InputDecoration(
                filled: true,
                fillColor:
                    Colors.grey, // Change this to your desired background color
                hintText: 'Name',
                hintStyle: defaultText),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          tagColour = Colors.red;
                          colourIndex = 0;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        width: blockSize,
                        height: blockSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.red,
                          border: Border.all(
                            color: colourIndex == 0
                                ? Colors
                                    .blueAccent // Change this to your desired outline color
                                : Colors
                                    .transparent, // No outline for other cases
                            width:
                                5.0, // Adjust the width of the outline as needed
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        tagColour = Colors.green;
                        setState(() {
                          colourIndex = 1;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        width: blockSize,
                        height: blockSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.green,
                          border: Border.all(
                            color: colourIndex == 1
                                ? Colors
                                    .blueAccent // Change this to your desired outline color
                                : Colors
                                    .transparent, // No outline for other cases
                            width:
                                5.0, // Adjust the width of the outline as needed
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        tagColour = Colors.blue;
                        setState(() {
                          colourIndex = 2;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        width: blockSize,
                        height: blockSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.blue,
                          border: Border.all(
                            color: colourIndex == 2
                                ? Colors.blue
                                    .shade700 // Change this to your desired outline color
                                : Colors
                                    .transparent, // No outline for other cases
                            width:
                                5.0, // Adjust the width of the outline as needed
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        tagColour = Colors.yellow;
                        setState(() {
                          colourIndex = 3;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        width: blockSize,
                        height: blockSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.yellow,
                          border: Border.all(
                            color: colourIndex == 3
                                ? Colors
                                    .blueAccent // Change this to your desired outline color
                                : Colors
                                    .transparent, // No outline for other cases
                            width:
                                5.0, // Adjust the width of the outline as needed
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        tagColour = Colors.purple;
                        setState(() {
                          colourIndex = 4;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        width: blockSize,
                        height: blockSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.purple,
                          border: Border.all(
                            color: colourIndex == 4
                                ? Colors
                                    .blueAccent // Change this to your desired outline color
                                : Colors
                                    .transparent, // No outline for other cases
                            width:
                                5.0, // Adjust the width of the outline as needed
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        tagColour = Colors.orange;
                        setState(() {
                          colourIndex = 5;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        width: blockSize,
                        height: blockSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.orange,
                          border: Border.all(
                            color: colourIndex == 5
                                ? Colors
                                    .blueAccent // Change this to your desired outline color
                                : Colors
                                    .transparent, // No outline for other cases
                            width:
                                5.0, // Adjust the width of the outline as needed
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        tagColour = Colors.black;
                        setState(() {
                          colourIndex = 6;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        width: blockSize,
                        height: blockSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.black,
                          border: Border.all(
                            color: colourIndex == 6
                                ? Colors
                                    .blueAccent // Change this to your desired outline color
                                : Colors
                                    .transparent, // No outline for other cases
                            width:
                                5.0, // Adjust the width of the outline as needed
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          tagColour = Colors.brown;
                          colourIndex = 7;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        width: blockSize,
                        height: blockSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.brown,
                          border: Border.all(
                            color: colourIndex == 7
                                ? Colors
                                    .blueAccent // Change this to your desired outline color
                                : Colors
                                    .transparent, // No outline for other cases
                            width:
                                5.0, // Adjust the width of the outline as needed
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Row(
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(10),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  label: Text('Cancel', style: headerText),
                  backgroundColor: Colors.red,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      widget.onCreation(_textEditingController.text, tagColour);
                      tagColour = Colors.red;
                    },
                    label: Text(' Create ', style: headerText),
                    backgroundColor: Colors.green,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                  )),
              const Spacer()
            ],
          ),
        ],
      ),
    );
  }
}
