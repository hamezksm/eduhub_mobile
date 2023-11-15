// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:eduhub_mobile/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatefulWidget {
  late final String welcomeMessage;
  OnBoarding({Key? key, required this.welcomeMessage}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut().then(
          (value) => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) => false,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Welcome, you are ${widget.welcomeMessage}'),
      ),
      drawer: Drawer(
        child: Center(
          child: IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
          ),
        ),
      ),
    );
  }
}
