import 'dart:ui';

import 'package:flutter/material.dart';

class InformationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Information om Pomodoro'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 23),
                margin: const EdgeInsets.only(top: 50),
              ),
              Container(
                width: 375,
                child: const Text(
                    'The Pomodoro technique suggests splitting tasks into small intervals of 25 minutes of working and 5 minutes of break. After four sets of 25 minutes focused time you end with a longer break of 15 minutes.',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              ),
              Container(
                padding: const EdgeInsets.only(left: 23),
                margin: const EdgeInsets.only(top: 30),
              ),
              Container(
                width: 375,
                child: const Text('Here are step-by-step instructions: ',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              ),
              Container(
                padding: const EdgeInsets.only(left: 23),
                margin: const EdgeInsets.only(top: 30),
              ),
              Container(
                width: 375,
                child: const Text(
                    '1. Pick the timer of 25 minutes (aka one Pomodoro). \n\n2. Get to work. \n\n3. Take a 5-minute break after your timer ends.\n\n4. During the break do something entirely different, for example: grab a cup of coffee or get some fresh air. \n\n5. When the short break is over, pick the timer of 25 minutes again and focus.\n\n6. Once youve done four of these 25-minute Pomodoros, take a longer break for 15 minutes.',
                    style:
                        TextStyle(fontSize: 17, fontStyle: FontStyle.italic)),
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
