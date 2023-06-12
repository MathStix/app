import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:nieuw/widgets/custom_timer.dart';
import '../repositories/general_repository.dart';
import '../widgets/background.dart';
import 'dart:math';

class FinalScreen extends StatefulWidget {
  @override
  _FinalScreenState createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen> {
  late CustomTimer customTimer;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    GeneralRepository.myBoolean.value = false;
    customTimer = CustomTimer();
    _confettiController = ConfettiController(duration: const Duration(seconds: 5));
  }

  @override
  void dispose() {
    _confettiController.dispose();
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0), // Voeg padding toe links en rechts
                child: Text(
                  'Gefeliciteerd, je hebt de game gehaald!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              ConfettiWidget(
                confettiController: _confettiController,
                blastDirection: -pi / 2,
                emissionFrequency: 0.05,
                numberOfParticles: 20,
                gravity: 0.1,
                shouldLoop: true,
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _startConfetti();
  }

  void _startConfetti() {
    _confettiController.play();
  }

  void _stopConfetti() {
    _confettiController.stop();
  }
}
