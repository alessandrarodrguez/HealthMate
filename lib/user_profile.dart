import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final List<String> backgrounds = [
    'assets/blueBackground.png',
    'assets/greenBackground.png',
    'assets/pinkBackground.png',
    'assets/purpleBackground.png',
    'assets/redBackground.png'
  ];

  final List<String> heads = [
    'assets/head1.png',
    'assets/head2.png',
    'assets/head3.png',
  ];

  final List<String> hairStyles = [
    'assets/blackHair1.png',
    'assets/blondeHair1.png',
    'assets/brownHair1.png',
    'assets/redHair1.png',
    'assets/blackHair2.png',
    'assets/blondeHair2.png',
    'assets/brownHair2.png',
    'assets/redHair2.png',
    'assets/cuteHairBlack.png',
    'assets/cuteHairBlonde.png',
    'assets/cuteHairRed.png',
    'assets/pigtailsBlonde.png',
    'assets/pigtailsBrown.png',
    'assets/pigtailsRed.png'
  ];

  final List<String> expressions = [
    'assets/faceBlush.png',
    'assets/faceCute.png',
    'assets/faceElated.png',
    'assets/faceSmile.png',
    'assets/faceSmirk.png'
  ];

  int backgroundIndex = 0;
  int headIndex = 0;
  int hairIndex = 0;
  int expressionIndex = 0;

  void cycleImage(List<String> list, int direction, Function(int) updateIndex, int currentIndex) {
    setState(() {
      int newIndex = (direction == 1)
          ? (currentIndex + 1) % list.length
          : (currentIndex - 1 + list.length) % list.length;
      updateIndex(newIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffd4a5c2),
      appBar: AppBar(title: const Text("User Profile")),
      body: Column(
        children: [
          const SizedBox(height: 20),

          // Box that shows the selected profile look
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(backgrounds[backgroundIndex], width: 200, height: 200, fit: BoxFit.cover),
                Image.asset(heads[headIndex], width: 150, height: 150),
                Image.asset(hairStyles[hairIndex], width: 160, height: 160),
                Image.asset(expressions[expressionIndex], width: 140, height: 140),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Container with BoxDecoration to add space for other buttons
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                // Background selection row
                buildSelectionRow("Background", backgrounds, (i) => setState(() => backgroundIndex = i), backgroundIndex),

                const SizedBox(height: 10),

                // Head selection row
                buildSelectionRow("Head", heads, (i) => setState(() => headIndex = i), headIndex),

                const SizedBox(height: 10),

                // Hair selection row
                buildSelectionRow("Hair", hairStyles, (i) => setState(() => hairIndex = i), hairIndex),

                const SizedBox(height: 10),

                // Expression selection row
                buildSelectionRow("Expression", expressions, (i) => setState(() => expressionIndex = i), expressionIndex),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Creates a selection row with left and right arrows horizontally
  Widget buildSelectionRow(String title, List<String> list, Function(int) updateIndex, int currentIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Left Arrow Button
        IconButton(
          icon: const Icon(Icons.arrow_left, size: 30),
          onPressed: () => cycleImage(list, -1, updateIndex, currentIndex),
        ),

        // Label Name
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

        // Right Arrow Button
        IconButton(
          icon: const Icon(Icons.arrow_right, size: 30),
          onPressed: () => cycleImage(list, 1, updateIndex, currentIndex),
        ),
      ],
    );
  }
}