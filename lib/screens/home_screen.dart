import 'package:flutter/material.dart';
import '../widgets/background.dart';


void main() {
  runApp(HomeScreen());
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GradientBackground( // Gebruik de GradientBackground widget als achtergrond
          child: Center(
            child: Text(
              'Andere pagina',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}