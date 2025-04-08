import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:healthmate_2/user_cust.dart'; // Import UserCust screen
import 'package:healthmate_2/contact_us.dart'; // Import ContactUs screen

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
  String username = ''; // stores the username

  // Load preferences and username
  Future<void> _loadSelections() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      backgroundIndex = prefs.getInt('backgroundIndex') ?? 0;
      headIndex = prefs.getInt('headIndex') ?? 0;
      hairIndex = prefs.getInt('hairIndex') ?? 0;
      expressionIndex = prefs.getInt('expressionIndex') ?? 0;
      username = prefs.getString('username') ?? "Guest"; // loads saved username
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSelections(); // Load saved preferences and username when the page loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd4a5c2),
      appBar: AppBar(
        title: const Text("User Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: () {
              // Navigate to ContactUs screen when message icon is tapped
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactUs()),
              );
            },
          ),
        ],
      ),
      body: Center( // This ensures everything is centered horizontally
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Align everything to the top
          children: [
            const SizedBox(height: 20),
            // Display the customized profile picture
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
            // Display the saved username underneath the profile picture
            Text(
              username, // This will display the saved username
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            // Button for User Character Customization
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserCust()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50), // Wide button
                backgroundColor: Colors.purple, // Button color
                foregroundColor: Colors.white, // Text color
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text("User Character Customization"), // Button text
            ),
          ],
        ),
      ),
    );
  }
}
