import 'package:flutter/material.dart';
import 'package:nieuw/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeData(
          textTheme: const TextTheme(
            //Stukje code waarmee je tekst componenten maakt
              titleLarge: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              )
          )
      ),
    );
  }
}
