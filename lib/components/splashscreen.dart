import 'dart:async';

import 'package:flutter/material.dart';
import 'package:golocate/components/login_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () => 
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage())));
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              const Color(0xFF0091EA).withOpacity(0.4),
              const Color(0xFFB3E5FC).withOpacity(0.7), 
              const Color(0xFFB3E5FC).withOpacity(0.7),
              const Color(0xFF0091EA).withOpacity(0.4), 
            ],
          ),
        ),
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Image.asset(
                "assets/Logo.png",
                height: 60,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 10),
              Text("GoLocate", style: TextStyle(
                fontSize: 35, 
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary)),
              ],
            )
          ],
        )),
      ),
    );
  }
}