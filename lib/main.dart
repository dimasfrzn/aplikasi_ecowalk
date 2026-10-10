import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const EcoWalkApp());
}

class EcoWalkApp extends StatelessWidget {
  const EcoWalkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoWalk',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}