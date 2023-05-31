import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child; // Voeg de 'child' parameter toe

  const GradientBackground(
      {super.key, required this.child}); // Definieer de constructor

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(
              0xFF16164D,
            ),
            Color(
              0xFFFA6666,
            ),
          ],
        ),
      ),
      child: child, // Gebruik de 'child' parameter als de widget-inhoud
    );
  }
}
