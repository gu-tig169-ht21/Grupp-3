import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/views/homepageview.dart';
import 'package:ndialog/ndialog.dart';
import 'informationview.dart';
import 'timerbuttons.dart';

class ThirdTimerView extends StatefulWidget {
  @override
  State<ThirdTimerView> createState() => _ThirdTimerView();
}

class _ThirdTimerView extends State<ThirdTimerView> {
  static const countDownDuration = Duration(minutes: 0, seconds: 3);
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
      title: Text("Timer Completed"),
      content: Text("Congrats, you have now finished the set!"),
      actions: <Widget>[
        ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateColor.resolveWith((states) => Colors.blue),
            ),
            child: Text("Close"), 
            onPressed: () {
              Navigator.pop(context);
              reset();
            }),
      ],
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      padding: EdgeInsets.all(10.0),
      minimumSize: const Size(20.0, 20.0),
    );
    return Scaffold(
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
