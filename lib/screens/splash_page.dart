import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Image(
        image: AssetImage("assets/images/1.png"),
        fit: BoxFit.fill,
      ),
      floatingActionButton: Align(
        alignment: const Alignment(1, 0.94),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed("/");
          },
          backgroundColor: Colors.transparent,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }
}
