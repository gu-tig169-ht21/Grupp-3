import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'timerbuttons.dart';

//Timer på 5 minuter
class ShortBreakTimerView extends StatefulWidget {
  const ShortBreakTimerView({Key? key}) : super(key: key);

  @override
  State<ShortBreakTimerView> createState() => _ShortBreakTimerView();
}

class _ShortBreakTimerView extends State<ShortBreakTimerView> {
  static const countDownDuration = Duration(minutes: 5, seconds: 0);
  Duration duration =
      countDownDuration; //Delar upp tidsspann i minuter och sekunder med hjälp av raden ovanför

  Timer? timer; //Inbyggd timer i flutter som räknar ner till 0

  bool countDown = true; //Deklararer att countdown är en boolean

  //Initierar state för att kunna setState
  void initstate() {
    super.initState();
    reset();
  }

  //Startar timer
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
    setState(() {});
  }

  //Nedräknarfunktion
  void addTime() {
    final addSeconds =
        countDown ? -1 : 1; //Ser till att en sekund alltid försvinner
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      if (seconds < 0) {
        //När seconds blir mindre än 0 stannar timern
        timer?.cancel();
        finishedTimer();
      } else {
        //Annars fortsätter timern
        duration = Duration(seconds: seconds);
      }
    });
  }

  //Avbryter timern och Pausar timern om resets är false
  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    setState(() => timer?.cancel());
  }

  //Återställer värdet på timer
  void reset() {
    if (countDown) {
      setState(() => duration = countDownDuration);
    } else {
      setState(() => duration = const Duration());
    }
  }

  //Dialogruta när timern är klar. Används i addTime när timern nått 0
  void finishedTimer() async {
    await NDialog(
      dialogStyle: DialogStyle(titleDivider: true),
      title: const Icon(Icons.alarm_on),
      content: const Text(
        'Time to study!',
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

  //Här är uppbyggnaden för nedräkningsknapparna i timern
  Widget timeWidget() {
    String twoNumbers(int number) => number.toString().padLeft(2, '0');
    final minutes = twoNumbers(duration.inMinutes.remainder(60));
    final seconds = twoNumbers(duration.inSeconds.remainder(60));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        timeWidgetCard(
          time: minutes,
          header: 'MINUTES',
        ),
        const SizedBox(width: 7),
        timeWidgetCard(
          time: seconds,
          header: 'SECONDS',
        )
      ],
    );
  }

  //Hur nedräkningen ska reagera beroende på state
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
                    stopTimer(resets: false); //Stoppar timern utan att reseta
                  }
                }),
            const SizedBox(width: 10),
            MainTimerButton(
                text: 'Cancel',
                color: Colors.grey.shade200,
                backgroundColor: Colors.blue.shade800,
                onClicked: () {
                  stopTimer(); //Stoppar och resetar timern
                })
          ])
        : MainTimerButton(
            text: 'Start Timer',
            color: Colors.grey.shade200,
            backgroundColor: Colors.blue.shade800,
            onClicked: () {
              startTimer(); //Timern startas
            });
  }
}
