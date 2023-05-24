import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:nieuw/main.dart';
import '../widgets/background.dart';

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late DateTime startTime;
  late Timer timer;
  String formattedTime = '00:00';
  List<String> code = List.generate(6, (_) => '');
  List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    startTime = DateTime.now();
    startTimer();
    focusNodes[0].requestFocus();
  }

  @override
  void dispose() {
    timer.cancel();
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        Duration timeElapsed = DateTime.now().difference(startTime);
        formattedTime = formatDuration(timeElapsed);
      });
    });
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

  void handleKeyPress(RawKeyEvent event, int index) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.backspace) {
        if (index > 0) {
          setState(() {
            focusNodes[index - 1].requestFocus();
            code[index - 1] = '';
          });
        }
      } else if (event.logicalKey == LogicalKeyboardKey.enter ||
          event.logicalKey == LogicalKeyboardKey.space) {
        if (index < 5) {
          setState(() {
            focusNodes[index + 1].requestFocus();
          });
        }
      } else {
        String keyPressed = event.character?.toUpperCase() ?? '';
        if (keyPressed.isNotEmpty) {
          setState(() {
            code[index] = keyPressed;
          });
          if (index < 5) {
            setState(() {
              focusNodes[index + 1].requestFocus();
            });
          }
        }
      }
    }
  }

  bool isCodeCorrect() {
    String enteredCode = code.join('');
    String hardcodedCode = 'ABCDEF'; // Hardcoded code
    return enteredCode.toLowerCase() == hardcodedCode.toLowerCase();
  }

  void submitCode() {
    if (isCodeCorrect()) {
      // Code is correct, perform desired action
      print('Code is correct');
    } else {
      // Code is incorrect, display error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Foutieve code'),
            content: Text('De ingevoerde code is incorrect. Probeer het opnieuw.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GradientBackground(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 42),
                alignment: Alignment.center,
                child: Text(
                  'Kies een vraag',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 40,
                    child: RawKeyboardListener(
                      focusNode: focusNodes[index],
                      onKey: (event) => handleKeyPress(event, index),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                        ),
                        child: Text(
                          code[index],
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: submitCode,
                  child: Text('Selecteer Code'),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 42),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Huidige tijd:',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        formattedTime,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}