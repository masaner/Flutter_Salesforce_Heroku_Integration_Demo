import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:student_management/models/environment.dart';
import 'package:student_management/screens/intro.dart';
import 'package:student_management/screens/sf_users.dart';
import 'package:student_management/screens/users.dart';

Future<void> main() async {
  await dotenv.load(fileName: Environment.fileName);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
    title: 'Named Routes Demo',
    initialRoute: '/',
    routes: {
      '/': (context) => AllUsers(),
      '/users': (context) => AllUsers(),
      '/accounts': (context) => AllSFUsers(),
      '/weather': (context) => IntroScreen(),
    },
  ));
}
