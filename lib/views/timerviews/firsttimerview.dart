import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'timerbuttons.dart';

class FirstTimerView extends StatefulWidget {
  const FirstTimerView({Key? key}) : super(key: key);

  @override
  State<FirstTimerView> createState() => _FirstTimerView();
}

class _FirstTimerView extends State<FirstTimerView> {
  static const countDownDuration =
      Duration(minutes: 0, seconds: 3); // KOM IHÅG ATT ÄNDRA TILL 25 MINUTER
  Duration duration = countDownDuration;

  Timer? timer;

  bool countDown = true;

  void initstate() {
    super.initState();
    reset();
  }

  void reset() {
    if (countDown) {
      setState(() => duration = countDownDuration);
    } else {
      setState(() => duration = const Duration());
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    final addSeconds = countDown ? -1 : 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      if (seconds < 0) {
        timer?.cancel();
        finishedTimer();
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

  void finishedTimer() async {
    await NDialog(
      dialogStyle: DialogStyle(titleDivider: true),
      title: const Icon(Icons.alarm_on),
      content: const Text(
        'Time for a break',
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateColor.resolveWith((states) => Colors.blue),
            ),
            child: const Text('Close'),
            onPressed: () {
              Navigator.pop(context);
              reset();
            }),
      ],
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            timeWidget(),
            const SizedBox(
              height: 20,
            ),
            stopWidget(),
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
          header: 'Minutes  /',
        ),
        const SizedBox(width: 7),
        timeWidgetCard(
          time: seconds,
          header: 'Seconds',
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
                text: 'Pause',
                color: Colors.blue.shade800,
                backgroundColor: Colors.grey.shade200,
                onClicked: () {
                  if (isLive) {
                    stopTimer(resets: false);
                  }
                }),
            const SizedBox(width: 10),
            MainTimerButton(
                text: 'Cancel',
                color: Colors.grey.shade200,
                backgroundColor: Colors.blue.shade800,
                onClicked: () {
                  stopTimer();
                })
          ])
        : MainTimerButton(
            text: 'Start Timer',
            color: Colors.grey.shade200,
            backgroundColor: Colors.blue.shade800,
            onClicked: () {
              startTimer();
            });
  }
}
