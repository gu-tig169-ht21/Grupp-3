import 'dart:ui';

import 'package:flutter/material.dart';

class InformationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Information Pomodoro'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 23),
                margin: const EdgeInsets.only(top: 30),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.only(left: 23, right: 23),
                  child: const Text(
                      'The Pomodoro technique suggests splitting tasks into small intervals of 25 minutes of working and 5 minutes of break. After four sets of 25 minutes of work you end with a longer break of 15 minutes.\n\nHere are step-by-step instructions:',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 23),
                margin: const EdgeInsets.only(top: 20),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.only(left: 23, right: 23),
                  child: const Text(
                      '1. Pick the timer of 25 minutes (aka one Pomodoro) and get to work!\n\n2. Take a 5-minute break after your timer ends.\n\n3. During the break do something entirely different like getting some fresh air. \n\n4. When the short break is over, pick the timer of 25 minutes again and focus.\n\n5. Once youve done four of these 25-minute Pomodoros, take a longer break for 15 minutes.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 19)),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 23),
                margin: const EdgeInsets.only(top: 30),
              ),
            ],
          ),
        ));
  }
}
