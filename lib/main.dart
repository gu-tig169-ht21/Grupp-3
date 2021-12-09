import 'package:flutter/material.dart';
import 'views/homepageview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: FutureBuilder(builder: (context, snapshot) {
        if (snapshot.hasError) {
           print ('You have an error! ${snapshot.error.toString()}');
           return const Text('Something went wrong');
        }
        else if (snapshot.hasData) {
          return const HomePage();
        }
        else {
          return const Center(child: CircularProgressIndicator(),
          );
        }
      }
      ),
      //const HomePage(),
    );
  }
}
