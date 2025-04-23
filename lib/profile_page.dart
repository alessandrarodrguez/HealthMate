import 'package:flutter/material.dart';
import 'package:healthmate_2/settings.dart';
import 'package:healthmate_2/terms_and_conditions.dart';
import 'package:healthmate_2/user_cust.dart';
import 'package:healthmate_2/contact_us.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



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

  // firestore stuff
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? userId;

  // Variables for user information
  DateTime? selectedBirthday;
  String location = '';
  double weight = 0.0;
  String height = '', waist = '', butt = '', bust = '';


  // Load preferences and username
  Future<void> _loadSelections() async {
  if (userId == null) return;

  try {
    // Read from 'users' collection
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();

    // Read from 'customizations' collection
    DocumentSnapshot customizationDoc = await FirebaseFirestore.instance
        .collection('customizations')
        .doc(userId)
        .get();

    setState(() {
      // Handle 'users' data
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        username = userData['username'] ?? "Guest";
        location = userData['location'] ?? '';
        weight = (userData['weight'] ?? 0.0).toDouble();
        height = userData['height'] ?? '';
        waist = userData['waist'] ?? '';
        butt = userData['butt'] ?? '';
        bust = userData['bust'] ?? '';
        if (userData['birthday'] != null) {
          selectedBirthday = DateTime.tryParse(userData['birthday']);
        }
      }

      // Handle 'customizations' data
      if (customizationDoc.exists) {
        final customizationData = customizationDoc.data() as Map<String, dynamic>;
        backgroundIndex = customizationData['backgroundIndex'] ?? 0;
        headIndex = customizationData['headIndex'] ?? 0;
        hairIndex = customizationData['hairIndex'] ?? 0;
        expressionIndex = customizationData['expressionIndex'] ?? 0;
      }
    });
  } catch (e) {
    print("Failed to load profile data: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Failed to load profile: $e")),
    );
  }
}



Future<void> _saveToFirestore() async {
  if (userId == null) return;

  await _firestore.collection('users').doc(userId).set({
    //'backgroundIndex': backgroundIndex,
    //'headIndex': headIndex,
    //'hairIndex': hairIndex,
    //'expressionIndex': expressionIndex,
    'username': username,
    'location': location,
    'weight': weight,
    'height': height,
    'waist': waist,
    'butt': butt,
    'bust': bust,
    'birthday': selectedBirthday?.toIso8601String(),
  }, SetOptions(merge: true)); // Only updates changed fields
}




  @override
void initState() {
  super.initState();
  userId = _auth.currentUser?.uid;
  _loadSelections();
}



  Future<void> _pickBirthday(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedBirthday ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        selectedBirthday = pickedDate;
      });
      await _saveToFirestore();
    }
  }


  Future<void> _pickLocation(BuildContext context) async {
    String? newLocation = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        TextEditingController controller = TextEditingController(text: location);
        return AlertDialog(
          title: const Text('Enter Location'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: "Location"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, controller.text);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
    if (newLocation != null && newLocation.isNotEmpty) {
      setState(() {
        location = newLocation;
      });
      await _saveToFirestore();
    }
  }


  Future<void> _pickWeight(BuildContext context) async {
    TextEditingController controller = TextEditingController(text: weight.toString());
    String? newWeight = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Weight'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: "Weight in lbs"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, controller.text);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
    if (newWeight != null && newWeight.isNotEmpty) {
      setState(() {
        weight = double.tryParse(newWeight) ?? 0.0;
      });
      await _saveToFirestore();
    }
  }


  Future<void> _pickMeasurements(BuildContext context) async {
    TextEditingController heightController = TextEditingController(text: height);
    TextEditingController waistController = TextEditingController(text: waist);
    TextEditingController buttController = TextEditingController(text: butt);
    TextEditingController bustController = TextEditingController(text: bust);


    String? newMeasurements = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Measurements'),
          content: SingleChildScrollView(
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      TextField(
        controller: heightController,
        decoration: const InputDecoration(hintText: "Height in inches"),
      ),
      TextField(
        controller: waistController,
        decoration: const InputDecoration(hintText: "Waist in inches"),
      ),
      TextField(
        controller: buttController,
        decoration: const InputDecoration(hintText: "Butt in inches"),
      ),
      TextField(
        controller: bustController,
        decoration: const InputDecoration(hintText: "Bust in inches"),
      ),
    ],
  ),
),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'done');
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );


    if (newMeasurements != null) {
      setState(() {
        height = heightController.text;
        waist = waistController.text;
        butt = buttController.text;
        bust = bustController.text;
      });
      await _saveToFirestore();
    }
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
    body: SingleChildScrollView( // Wrap the entire body inside SingleChildScrollView
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Display the customized profile picture
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color.fromARGB(255, 7, 76, 133), width: 2),
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
                color: Color.fromARGB(255, 7, 76, 133),
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
                minimumSize: const Size(200, 50),
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  side: const BorderSide(color: Color(0xFF1A85F8), width: 2),
              ),
              child: const Text("User Character Customization"),
            ),
            const SizedBox(height: 15),
            // Grid for PNG Buttons (4 square setup)
            GridView.count(
              shrinkWrap: true, // Makes the grid take only as much space as needed
              physics: NeverScrollableScrollPhysics(), // Disable scrolling inside GridView
              crossAxisCount: 2, // 2 columns
              crossAxisSpacing: 15, // Spacing between columns
              mainAxisSpacing: 10, // Spacing between rows
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              children: [
                _buildPngButton(
                  imagePath: 'assets/birthday.png',
                  text: 'Birthday',
                  onPressed: () => _pickBirthday(context),
                ),
                _buildPngButton(
                  imagePath: 'assets/location.png',
                  text: 'Location',
                  onPressed: () => _pickLocation(context),
                ),
                _buildPngButton(
                  imagePath: 'assets/weight.png',
                  text: 'Weight',
                  onPressed: () => _pickWeight(context),
                ),
                _buildPngButton(
                  imagePath: 'assets/measurements.png',
                  text: 'Measurements',
                  onPressed: () => _pickMeasurements(context),
                ),
              ],
            ),
const SizedBox(height: 15),
            // Two side-by-side styled buttons (inside Column)
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      // Read Policies Button (wider)
      SizedBox(
        width: 150,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TermsAndConditionsPage()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: const BorderSide(color: Color(0xFF1A85F8), width: 2),
            ),
          ),
          child: const Text(
            "Read our privacy and AI policies!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      const SizedBox(width: 10),
      // Settings Button (narrower)
      SizedBox(
        width: 100,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsPage()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: const BorderSide(color: Color(0xFF1A85F8), width: 2),
            ),
          ),
          child: const Text(
            "Settings",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ],
  ),
),


          ],
        ),
      ),
    ),
  );
}

Widget _buildPngButton({required String imagePath, required String text, required VoidCallback onPressed}) {
  return Column(
    children: [
      GestureDetector(
        onTap: onPressed,
        child: Image.asset(
          imagePath,
          width: 160,
          height: 160,
        ),
      ),
      Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 7, 76, 133),
          ),
        ),
      ],
    );
  }
}