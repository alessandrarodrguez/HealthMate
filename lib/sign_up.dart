import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isVisible = false;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: const BoxDecoration(
          color: Color(0xffd4a5c2),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              width: screenWidth,
              child: Container(
                width: screenWidth,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xffc5c5ff),
                  border: Border.all(
                    color: const Color(0xff004aad),
                    width: 3,
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: screenHeight * 0.05,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff9e31bd),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      "Happy to see a new face!",
                      style: GoogleFonts.playfairDisplay(
                        fontSize: screenHeight * 0.04,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: const Color(0xFF0093c1),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Back Button
            Positioned(
              top: screenHeight * 0.06,
              left: screenWidth * 0.07,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset('assets/back.PNG', height: 90, width: 90),
              ),
            ),

            // Flower Image
            Positioned(
              top: screenHeight * 0.01,
              right: screenWidth * 0.02,
              child: Image.asset('assets/flowers.PNG', height: 150, width: 150),
            ),

            Positioned(
              bottom: screenHeight * 0.00,
              right: screenWidth * 0.00,
              child: Image.asset('assets/talkingflower2.PNG', height: 230, width: 230),
            ),

            // Inputting Username
            Positioned(
              top: screenHeight * 0.35,
              left: screenWidth * 0.15,
              right: screenWidth * 0.15,
              child: Container(
                height: screenHeight * 0.07,
                decoration: BoxDecoration(
                  color: const Color(0xFF9e31bd),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: const Color(0xFF9e31bd)),
                ),
                child: TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    icon: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(Icons.person, color: Color(0xffb1deef)),
                    ),
                    hintText: 'Username',
                    hintStyle: TextStyle(color: Color(0xffb1deef)),
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: InputBorder.none,
                  ),
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffb1deef),
                  ),
                ),
              ),
            ),

            // Email
            Positioned(
              top: screenHeight * 0.44,
              left: screenWidth * 0.15,
              right: screenWidth * 0.15,
              child: Container(
                height: screenHeight * 0.07,
                decoration: BoxDecoration(
                  color: const Color(0xFF9e31bd),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: const Color(0xFF9e31bd)),
                ),
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    icon: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(Icons.mail, color: Color(0xffb1deef)),
                    ),
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Color(0xffb1deef)),
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: InputBorder.none,
                  ),
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffb1deef),
                  ),
                ),
              ),
            ),

            // Inputting Password
            Positioned(
              top: screenHeight * 0.53,
              left: screenWidth * 0.15,
              right: screenWidth * 0.15,
              child: Container(
                height: screenHeight * 0.07,
                decoration: BoxDecoration(
                  color: const Color(0xFF9e31bd),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: const Color(0xFF9e31bd)),
                ),
                child: TextField(
                  controller: _passwordController,
                  obscureText: !isVisible,
                  decoration: InputDecoration(
                    icon: const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(Icons.lock, color: Color(0xffb1deef)),
                    ),
                    hintText: 'Password',
                    hintStyle: const TextStyle(color: Color(0xffb1deef)),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      icon: const Icon(Icons.visibility, color: Color(0xffb1deef)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: InputBorder.none,
                  ),
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffb1deef),
                  ),
                ),
              ),
            ),

            // Submit Button
            Positioned(
              top: screenHeight * 0.62,
              left: screenWidth * 0.33,
              right: screenWidth * 0.33,
              child: GestureDetector(
                onTap: signUp,
                child: Container(
                  width: double.infinity,
                  height: screenHeight * 0.04,
                  decoration: BoxDecoration(
                    color: const Color(0xffb1deef),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      "Submit",
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF9e31bd),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Sign In Link
            Positioned(
              bottom: screenHeight * 0.01,
              left: screenWidth * 0.43,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/signin");
                },
                child: Text(
                  "Sign In",
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                    color: const Color(0xFF0093c1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<User?> createUserWithEmailAndPassword(BuildContext context, String email, String password) async {
    try {
      UserCredential credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(content: Text(e.message.toString()));
        },
      );
      return null;
    }
  }

  // The method that calls createUserWithEmailAndPassword and performs navigation
  void signUp() async {
    User? user = await createUserWithEmailAndPassword(
      context,
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    // If user is created, save the username locally and navigate to the home screen
    if (user != null) {
      await saveUsernameLocally(_usernameController.text.trim());
      Navigator.pushNamed(context, '/home');
    }
  }

  // Save the username locally using SharedPreferences
  Future<void> saveUsernameLocally(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }
}
