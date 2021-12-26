import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'firsttimerview.dart';
import 'secondtimerview.dart';

class ThirdTimerView extends StatefulWidget {
  @override
  State<ThirdTimerView> createState() => _ThirdTimerView();
}

class _ThirdTimerView extends State<ThirdTimerView> {
  static const countDownDuration = Duration(minutes: 15, seconds: 0);
  Duration duration = countDownDuration;

  Timer? timer;

  bool countDown = true;
  @override
  void initstate() {
    super.initState();
    reset();
  }

  void reset() {
    if (countDown) {
      setState(() => duration = countDownDuration);
    } else {
      setState(() => duration = Duration());
    }
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    final addSeconds = countDown ? -1 : 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      if (seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    setState(() => timer?.cancel());
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      padding: EdgeInsets.all(10.0),
      minimumSize: const Size(20.0, 20.0),
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Plugga med Pomodoro'),
      ),
      body: Center(
        child: Column(
          children: [
            buttonWidget(),
            SizedBox(
              height: 200,
            ),
            timeWidget(),
            SizedBox(
              height: 20,
            ),
            stopWidget(),
          ],
        ),
      ),
    );
  }

  Widget buttonWidget() {
    final isLive = timer == null ? false : timer!.isActive;
    final isDone = duration.inSeconds == 0;
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      ElevatedButton(
        onPressed: () {
          if (isLive) {
            stopTimer();
          }
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FirstTimerView()));
        },
        child: const Text('Pluggtimer'),
      ),
      Container(width: 10),
      ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SecondTimerView()));
        },
        child: const Text('Kort rast'),
      ),
      Container(width: 10),
      ElevatedButton(
        onPressed: () {},
        child: const Text('Lång rast'),
      ),
    ]);
  }

  Widget timeWidget() {
    String twoNumbers(int number) => number.toString().padLeft(2, '0');
    final minutes = twoNumbers(duration.inMinutes.remainder(60));
    final seconds = twoNumbers(duration.inSeconds.remainder(60));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        timeWidgetCard(
          time: minutes,
          header: 'MINUTER',
        ),
        SizedBox(width: 7),
        timeWidgetCard(
          time: seconds,
          header: 'SEKUNDER',
        )
      ],
    );
  }

  Widget timeWidgetCard({required String time, required String header}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: Colors.lightBlue[700],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              time,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                  fontSize: 40),
            ),
          ),
          SizedBox(height: 20),
          Text(header, style: TextStyle(color: Colors.grey)),
        ],
      );

  Widget stopWidget() {
    final isLive = timer == null ? false : timer!.isActive;
    final isDone = duration.inSeconds == 0;
    return isLive || isDone
        ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ButtonWidget(
                text: 'Pausa',
                color: Colors.blue.shade800,
                backgroundColor: Colors.grey.shade200,
                onClicked: () {
                  if (isLive) {
                    stopTimer(resets: false);
                  }
                }),
            SizedBox(width: 10),
            ButtonWidget(
                text: 'Avbryt',
                color: Colors.grey.shade200,
                backgroundColor: Colors.blue.shade800,
                onClicked: () {
                  stopTimer();
                })
          ])
        : ButtonWidget(
            text: 'Starta Timer',
            color: Colors.grey.shade200,
            backgroundColor: Colors.blue.shade800,
            onClicked: () {
              startTimer();
            });
  }
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final Color color;
  final Color backgroundColor;
  final VoidCallback onClicked;

  const ButtonWidget(
      {Key? key,
      required this.text,
      required this.onClicked,
      this.color = Colors.white,
      this.backgroundColor = Colors.grey})
      : super(key: key);
  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: backgroundColor,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 17)),
        onPressed: onClicked,
        child: Text(
          text,
          style: TextStyle(fontSize: 21, color: color),
        ),
      );
}
