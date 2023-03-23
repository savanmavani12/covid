import 'package:covid/screens/home_page.dart';
import 'package:covid/screens/splash_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: "Splash",
      routes: {
        "/": (context) => const HomePage(),
        "Splash": (context) => const SplashPage(),
      },
    ),
  );
}
