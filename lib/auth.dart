import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthmate_2/login_screen.dart';
import 'home_screen.dart';

class Auth extends StatelessWidget {
  //final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context, snapshot) {
          // User logged in
          if (snapshot.hasData) {
            return HomePage();
          }
          // User not logged in
          else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
