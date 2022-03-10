import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movies_list_app/Pages/homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool selected = false;
  bool visible = false;
  @override
  void initState() {
    setState(() {
      selected = true;
      visible = true;
    });

    super.initState();
        settimer();

  }

  settimer() async {
    var duration = Duration(seconds: 3);
    return Timer(duration, secondpage);
  }

  secondpage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              width: selected ? 300.0 : 150.0,
              height: selected ? 300.0 : 150.0,
              curve: Curves.easeIn,
              duration: const Duration(seconds: 1),
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image:
                        DecorationImage(image: AssetImage("assets/logo.png"))),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            AnimatedOpacity(
                opacity: visible ? 1.0 : 0.0,
                duration: Duration(seconds: 3),
                child: Text(
                  "Welcome To Movie List",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ))
          ],
        ),
      ),
    );
  }
}
