import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:nieuw/models/Exercise.dart';
import 'package:nieuw/screens/maps_screen.dart';

import '../utils/screen_pusher.dart';
import '../widgets/background.dart';
import 'ability_screen.dart';

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late DateTime startTime;
  late Timer timer;
  String formattedTime = '00:00';
  List<String> code = List.generate(6, (_) => '');
  final List<TextEditingController> _codeControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  String _errorMessage = '';
  final controller = ConfettiController();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    startTime = DateTime.now();
    startTimer();
    controller.addListener(() {
      print("new event");
      isPlaying = controller.state == ConfettiControllerState.playing;
      print("isplaying : $isPlaying");
    });
  }

  void load() async {
    // Api call:
    setState(() {
      //
    });
  }

  @override
  void dispose() {
    timer.cancel();
    controller.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GradientBackground(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Text('Kies een vraag',
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                  Text(
                    'Voer de 6-letterige code in:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (int i = 0; i < 6; i++)
                        Container(
                          alignment: Alignment.center,
                          width: 50.0,
                          child: TextField(
                            controller: _codeControllers[i],
                            focusNode: _focusNodes[i],
                            maxLength: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _errorMessage = '';
                              });
                              if (value.isNotEmpty && i < 5) {
                                _focusNodes[i + 1].requestFocus();
                              }
                              if (value.isEmpty && i > 0) {
                                _focusNodes[i - 1].requestFocus();
                              }
                            },
                            onSubmitted: (value) {
                              if (value.isEmpty && i > 0) {
                                _focusNodes[i - 1].requestFocus();
                              }
                            },
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(40.0, 65.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      primary: Color(0xFFFA6666),
                    ),
                    child: Text(
                      'Doorgaan',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    _errorMessage,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  CustomButton(
                    exercise: Exercise(
                        title: "Vraag 1",
                        description: "Beschrijving",
                        activationRange: "10",
                        exerciseType: "text",
                        answer: "100.0",
                        location: "12,12",
                        teacherId: "123",
                        photo: "123"),
                  ),
                  CustomButton(
                    exercise: Exercise(
                        title: "Vraag 2",
                        description: "Beschrijving",
                        activationRange: "10",
                        exerciseType: "photo",
                        answer: "100.0",
                        location: "12,12",
                        teacherId: "123",
                        photo: "123"),
                  ),
                  CustomButton(
                    exercise: Exercise(
                        title: "Vraag kaas",
                        description: "Beschrijving",
                        activationRange: "10",
                        exerciseType: "geo",
                        answer: "100.0",
                        location: "12,12",
                        teacherId: "123",
                        photo: "123"),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: Text(
                      'Tijd op pagina: $formattedTime',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: ConfettiWidget(
              confettiController: controller,
              shouldLoop: true,
              numberOfParticles: 100,
              blastDirection: -pi / 2,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final Exercise exercise;

  const CustomButton({required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        8.0,
      ),
      child: ElevatedButton(
        onPressed: () {
          switch (exercise.exerciseType) {
            case "text":
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => TextScreen()),
              // );
              break;
            case "geo":
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => MapsScreen()),
              // );
              break;
          }
        },
        style: ElevatedButton.styleFrom(
          fixedSize: Size.fromHeight(95.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          primary: Color(0xFFFA6666),
        ),
        child: Text(
          exercise.title,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class OtherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Other Page'),
      ),
      body: Center(
        child: Text('You have entered the correct code!'),
      ),
    );
  }
}
