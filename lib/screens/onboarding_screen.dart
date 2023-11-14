// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class OnBoarding extends StatefulWidget {
  late final String welcomeMessage;
  OnBoarding({Key? key, required this.welcomeMessage}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
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
    );
  }
}
