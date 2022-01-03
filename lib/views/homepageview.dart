import 'package:flutter/material.dart';
import 'package:my_first_app/views/taskview.dart';
import 'timerviews/firsttimerview.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Smart Study'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _logo(),
            Container(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FirstTimerView()));
              },
              child: const Text('PLUGGA'),
            ),
            Container(height: 25),
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

  Widget _logo() {
    return Stack(
      children: [
        const Image(image: AssetImage('assets/logo.png')),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 200,
            decoration: (BoxDecoration(
              border: Border.all(
                color: Colors.blueGrey,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(95),
            )),
          ),
        ),
      ],
    );
  }
}
