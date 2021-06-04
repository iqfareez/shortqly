import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shortqly/CONSTANTS.dart';
import 'package:shortqly/views/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppName,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: GoogleFonts.nunito().fontFamily),
      home: Home(kAppName),
    );
  }
}
