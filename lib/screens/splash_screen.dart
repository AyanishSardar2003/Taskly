import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:perfect_day/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool x = false;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
      Get.off(() => HomeScreen());
    });
    Future.delayed(const Duration(milliseconds: 3850), () {
      setState(() {
        x = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: ZoomIn(
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
                textAlign: TextAlign.center,
                style: TextStyle(color: Get.theme.hintColor, fontSize: 12),
                'dev'.tr)),
      ),
      body: ZoomOut(
        duration: const Duration(milliseconds: 250),
        animate: x,
        child: ZoomIn(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(),
              Image.asset(
                "assets/images/logo.png",
                height: 150,
                width: 150,
              ),
              Text(
                'Taskly',
                style: TextStyle(
                    fontSize: 40,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
