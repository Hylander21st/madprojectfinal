import 'package:flutter/material.dart';
import 'package:firebase_firestoreapp/screens/home_page.dart';
import 'package:firebase_firestoreapp/screens/login_page.dart';
import 'package:firebase_firestoreapp/screens/challenge_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Waste Wise',
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/challenges': (context) => ChallengePage(),
      },
      home: HomePage(),
    );
  }
}
