import 'package:flutter/material.dart';
import 'package:my_first_app/views/timerviews/firsttimerview.dart';
import 'thirdtimerview.dart';
import 'secondtimerview.dart';

class MainTimerButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color backgroundColor;
  final VoidCallback onClicked;

  const MainTimerButton(
      {required this.text,
      required this.onClicked,
      this.color = Colors.white,
      this.backgroundColor = Colors.grey});

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: backgroundColor,
            fixedSize: const Size(180, 70),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
        onPressed: onClicked,
        child: Text(
          text,
          style: TextStyle(
              fontSize: 21, color: color, fontWeight: FontWeight.bold),
        ),
      );
}

Widget timeWidgetCard({required String time, required String header}) => Column(
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
        Text(header, style: TextStyle(color: Colors.blueGrey)),
      ],
    );
