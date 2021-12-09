import 'package:flutter/material.dart';
import 'views/homepageview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
   MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: FutureBuilder(future: _fbApp, builder: (context, snapshot) {
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
