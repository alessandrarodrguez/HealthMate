import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:healthmate_2/auth.dart';
import 'package:healthmate_2/contact_us.dart';
import 'package:healthmate_2/password_reset.dart';
import 'package:healthmate_2/profile_page.dart';
import 'package:healthmate_2/user_cust.dart';
import 'sign_in.dart';
import 'sign_up.dart';
import 'home_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();  // Ensure proper initialization
  await Firebase.initializeApp();  // Initialize Firebase{
  runApp(const HealthMate());
}

class HealthMate extends StatelessWidget {
  const HealthMate({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",  // Set the initial screen
      routes: {
        "/": (context) => Auth(),  // Default home page
        "/signin": (context) => const SignIn(),  // Sign In page
        "/signup": (context) => const SignUp(),  // Sign Up page
        "/home": (context) => const HomePage(), // Home Page
        "/passwordreset": (context) => const PasswordReset(), // Password Reset Page
        "/userprofile": (context) => const UserCust(), // Character Customization
        "/profilepage": (context) => const ProfilePage(), // Profile Page,
        "/contactus": (context) => const ContactUs()
      },
    );
  }
}