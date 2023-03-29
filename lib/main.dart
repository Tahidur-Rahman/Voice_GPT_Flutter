import 'package:flutter/material.dart';
import 'package:voiceassistant/home_page.dart';
import 'package:voiceassistant/pallete.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Voice Assistant',
      theme: ThemeData.light().copyWith(
         scaffoldBackgroundColor: Pallete.whiteColor
      ),
      home: const HomePage(),
    );
  }
}

