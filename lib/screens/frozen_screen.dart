import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nieuw/screens/answerquestion_screen.dart';
import 'dart:async';

class FrozenScreen extends StatefulWidget {
  @override
  _FrozenScreenState createState() => _FrozenScreenState();
}

class _FrozenScreenState extends State<FrozenScreen> {
  int countdownDuration = 120; // 2 minutes in seconds
  Timer? countdownTimer;
  String countdownText = '02:00';

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  void startCountdown() {
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (countdownDuration > 0) {
          countdownDuration--;
          countdownText = formatCountdownTime(countdownDuration);
        } else {
          timer.cancel();
          // Countdown finished, navigate to next screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AnswerScreen()),
          );
        }
      });
    });
  }

  String formatCountdownTime(int duration) {
    int minutes = duration ~/ 60;
    int seconds = duration % 60;
    String formattedTime =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff17174E), Color(0xffB24C5D)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Center(
              child: Text(
                'Jullie zijn bevroren door groep x!',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: 180),
            Center(
              child: Image.asset(
                'assets/mdi_snowflake.png',
                width: 200,
                height: 200,
              ),
            ),
            SizedBox(height: 22),
            Center(
              child: Text(
                countdownText,
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            SizedBox(height: 220),
            Center(
              child: Text(
                'Veiligheid boven alles, sta niet stil op de weg!',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}