import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'firsttimerview.dart';
import 'informationview.dart';
import 'secondtimerview.dart';
import 'thirdtimerview.dart';

class MainTimerView extends StatelessWidget {
  const MainTimerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Study'),
              Tab(text: 'Short break'),
              Tab(text: 'Long break'),
            ],
          ),
          centerTitle: true,
          title: const Text('Study with Pomodoro'),
          actions: [
            IconButton(
              icon: const Icon(Icons.info_outline_rounded,
                  color: Colors.white, size: 35),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InformationView()));
              },
            ),
          ],
        ),
        body: const TabBarView(children: [
          Center(child: FirstTimerView()),
          Center(child: SecondTimerView()),
          Center(child: ThirdTimerView()),
        ]),
      ),
    );
  }
}
