import 'package:flutter/material.dart';
import 'package:my_first_app/views/taskview.dart';
import 'package:my_first_app/views/timerviews/timerview.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('StudyBuddy'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(height: 40),
            const Text('Pluggis-kompis'),
            Container(height: 20),
            ElevatedButton(
              onPressed: () {
               Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TimerView())); 
              },
              child: const Text('PLUGGA'),
            ),
            Container(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const TaskView()));
              },
              child: const Text('UPPGIFTER'),
            ),
          ],
        ),
      ),
    );
  }
}
