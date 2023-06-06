import 'package:flutter/material.dart';

import '../widgets/background.dart';

class GameCompletedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Gefeliciteerd, je hebt de game gehaald!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Voeg hier extra widgets toe als dat nodig is
            ],
          ),
        ),
      ),
    );
  }
}
