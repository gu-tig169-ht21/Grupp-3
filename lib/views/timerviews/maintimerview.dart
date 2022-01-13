import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'studytimerview.dart';
import 'informationview.dart';
import 'shortbreaktimerview.dart';
import 'longbreaktimerview.dart';

//Huvudsidan för pluggtimer
class MainTimerView extends StatelessWidget {
  const MainTimerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            //Valbara tabs
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
                        builder: (context) =>
                            const InformationView())); //Knapp till Infosida
              },
            ),
          ],
        ),
        //Navigation till de olika timersidorna
        body: const TabBarView(children: [
          Center(child: StudyTimerView()),
          Center(child: ShortBreakTimerView()),
          Center(child: LongBreakTimerView()),
        ]),
      ),
    );
  }
}
