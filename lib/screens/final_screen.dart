import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../widgets/background.dart';
import 'dart:math';

class FinalScreen extends StatelessWidget {
  final int timerSeconds;

  const FinalScreen({required this.timerSeconds});

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
              Text(
                'Tijd op de app: ${formatDuration(Duration(seconds: timerSeconds))}',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              ConfettiWidget(
                confettiController: ConfettiController(duration: const Duration(seconds: 5)),
                blastDirection: -pi / 2, // Richting van het afvuren van confetti
                emissionFrequency: 0.05, // Frequentie van confetti-afvuring (0.05 = 5% kans per frame)
                numberOfParticles: 20, // Aantal confetti-deeltjes per explosie
                gravity: 0.1, // Zwaartekracht voor de confetti-deeltjes
                shouldLoop: false, // Confetti loop na afvuren
                colors: const [
                  Color(0xFF99B4BF),
                  Color(0xFF2D4B73),
                  Color(0xFF253C59),
                ], // Lijst van kleuren voor de confetti-deeltjes
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String minutes = twoDigits(duration.inMinutes);
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
