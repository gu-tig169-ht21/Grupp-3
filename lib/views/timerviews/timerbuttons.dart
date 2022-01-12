import 'package:flutter/material.dart';

//Utseende för start/paus/cancel knapparna 
class MainTimerButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color backgroundColor;
  final VoidCallback onClicked;

  const MainTimerButton(
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

//Utseende för nedräkningsrutorna
Widget timeWidgetCard({required String time, required String header}) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(7),
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
        const SizedBox(height: 20),
        Text(header, style: const TextStyle(color: Colors.blueGrey)),
      ],
    );
