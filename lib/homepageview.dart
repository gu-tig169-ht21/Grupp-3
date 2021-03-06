import 'package:flutter/material.dart';
import 'package:my_first_app/views/taskviews/taskview.dart';
import 'package:my_first_app/views/timerviews/maintimerview.dart';

//Förstasidan i appen
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
            Container(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MainTimerView()));
              },
              child: const Text('STUDY'),
              style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  fixedSize: const Size(180, 70),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
            Container(height: 35),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const TaskView()));
              },
              child: const Text('ASSIGNMENTS'),
              style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  fixedSize: const Size(180, 70),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
          ],
        ),
      ),
    );
  }

  //Bild på ugglan
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
              shape: BoxShape.circle,
            )),
          ),
        ),
      ],
    );
  }
}
