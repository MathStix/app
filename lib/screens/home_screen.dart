import 'package:flutter/material.dart';
import '../widgets/background.dart';
import '../widgets/button.dart';


void main() {
  runApp(HomeScreen());
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            GradientBackground(
              child: const Center(
                child: Text(
                  'Andere pagina',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: CustomButton(),
            ),
          ],
        ),
      ),
    );
  }
}