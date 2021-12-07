import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('StudyBuddy'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(height: 40),
            const Text('Pluggis-kompis'),
            Container(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('PLUGGA'),
            ),
            Container(height: 30),
            ElevatedButton(
              onPressed: () {},
              child: const Text('UPPGIFTER'),
            ),
          ],
        ),
      ),
    );
  }
}
