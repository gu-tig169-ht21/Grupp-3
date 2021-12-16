import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimerView extends StatefulWidget {
  @override
  State<TimerView> createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> {
  static const countDownDuration = Duration(minutes: 25, seconds: 0);
  Duration duration = Duration();
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Plugga med Pomodoro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            timeWidget(),
            SizedBox(
              height: 20,
            ),
            stopWidget()
          ],
        ),
      ),
    );
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
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              time,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
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
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                  text: 'PAUSA',
                  onClicked: () {
                    if (isLive) {
                      stopTimer(resets: false);
                    }
                  }),
              SizedBox(width: 10),
              ButtonWidget(text: 'AVBRYT', onClicked: stopTimer),
            ],
          )
        : ButtonWidget(
            text: 'STARTA TIMER',
            color: Colors.grey,
            backgroundColor: Colors.white,
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
