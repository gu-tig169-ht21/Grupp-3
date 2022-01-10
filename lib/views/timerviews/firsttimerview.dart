import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/views/timerviews/informationview.dart';
import 'timerbuttons.dart';

class FirstTimerView extends StatefulWidget {
  @override
  State<FirstTimerView> createState() => _FirstTimerView();
}

class _FirstTimerView extends State<FirstTimerView> {
  static const countDownDuration = Duration(minutes: 25, seconds: 0);
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
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded,
                color: Colors.white, size: 35),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => InformationView()));
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            timeWidget(),
            SizedBox(
              height: 20,
            ),
            stopWidget(),
            SizedBox(
              height: 150,
            ),
            timerNavigationWidget(context),
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
          header: 'Minuter  /',
        ),
        SizedBox(width: 7),
        timeWidgetCard(
          time: seconds,
          header: 'Sekunder',
        )
      ],
    );
  }

  Widget stopWidget() {
    final isLive = timer == null ? false : timer!.isActive;
    final isDone = duration.inSeconds == 0;
    return isLive || isDone
        ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            MainTimerButton(
                text: 'Pausa',
                color: Colors.blue.shade800,
                backgroundColor: Colors.grey.shade200,
                onClicked: () {
                  if (isLive) {
                    stopTimer(resets: false);
                  }
                }),
            SizedBox(width: 10),
            MainTimerButton(
                text: 'Avbryt',
                color: Colors.grey.shade200,
                backgroundColor: Colors.blue.shade800,
                onClicked: () {
                  stopTimer();
                })
          ])
        : MainTimerButton(
            text: 'Starta Timer',
            color: Colors.grey.shade200,
            backgroundColor: Colors.blue.shade800,
            onClicked: () {
              startTimer();
            });
  }
}
