import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:nieuw/widgets/custom_timer.dart';
import '../widgets/background.dart';
import 'dart:math';

class FinalScreen extends StatefulWidget {
  @override
  _FinalScreenState createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen> {
  late CustomTimer customTimer;

  @override
  void initState() {
    super.initState();
    customTimer = CustomTimer();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                style: Theme.of(context).textTheme.titleLarge,
              ),
              ConfettiWidget(
                confettiController: ConfettiController(
                  duration: const Duration(seconds: 5),
                ),
                blastDirection: -pi / 2,
                emissionFrequency: 0.05,
                numberOfParticles: 20,
                gravity: 0.1,
                shouldLoop: false,
                colors: const [
                  Color(0xFF99B4BF),
                  Color(0xFF2D4B73),
                  Color(0xFF253C59),
                ],
              ),
              SizedBox(height: 20),
              CustomTimer(),
            ],
          ),
        ),
      ),
    );
  }
}
