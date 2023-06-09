import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:nieuw/models/Exercise.dart';
import 'package:nieuw/repositories/exercise_repository.dart';
import 'package:nieuw/repositories/shared_preferences_repository.dart';
import 'package:nieuw/screens/answers/calculate_screen.dart';
import 'package:nieuw/screens/final_screen.dart';
import 'package:nieuw/screens/maps_screen.dart';
import 'package:nieuw/screens/white_board_screen.dart';
import 'package:nieuw/widgets/custom_timer.dart';

import '../repositories/answer_repository.dart';
import '../repositories/game_repository.dart';
import '../repositories/websocket_repository.dart';
import '../utils/screen_pusher.dart';
import '../widgets/background.dart';
import '../widgets/custom_timer.dart';

import 'ability_screen.dart';
import 'frozen_screen.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen>
    with WidgetsBindingObserver {
  late Future<List<Exercise>> future;

  late DateTime startTime;
  late Timer timer;

  late ValueNotifier<int> seconds = ValueNotifier<int>(0);

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
    future =
        ExerciseRepository().getExercises(SharedPreferencesRepository.inTeam!);
    startTime = DateTime.now();
    startTimer();
    controller.addListener(() {
      isPlaying = controller.state == ConfettiControllerState.playing;
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
      seconds.value = DateTime.now().difference(startTime).inSeconds;
    });
  }

  void checkLetters() {
    setState(() {
      AnswerRepository.guessedLetters.forEach((element) {
        int position = element['position'];
        String letter = element['letter'];
        _codeControllers[position].text = letter;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GradientBackground(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Text(
                        'Kies een vraag',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Text(
                      'Voer de 6-letterige code in:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 10.0),
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
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
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
                    const SizedBox(height: 10.0),
                    ElevatedButton(
                      onPressed: () async {
                        String code = '';
                        for (int i = 0; i < 6; i++) {
                          code += _codeControllers[i].text.toLowerCase();
                        }

                        bool joined = await GameRepository.checkCode(code);
                        if (!joined) {
                          setState(() {
                            _errorMessage = 'Foute code. Probeer het opnieuw.';
                            print("Foute code");
                          });
                          return;
                        } else {
                          ScreenPusher.pushScreen(context, FinalScreen(), true);
                          // timerWidget.stopTimer(); // Roept stopTimer aan om de timer te stoppen
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(40.0, 65.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        primary: const Color(0xFFFA6666),
                      ),
                      child: const Text(
                        'Doorgaan',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      _errorMessage,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.red),
                    ),
                    const SizedBox(height: 10.0),
                    FutureBuilder(
                      future: future,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Exercise> exercises =
                              ExerciseRepository.exercises;
                          return SingleChildScrollView(
                            child: Column(
                              children: exercises
                                  .map((e) => CustomButton(
                                        exercise: e,
                                        callback: checkLetters,
                                      ))
                                  .toList(),
                            ),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    CustomTimer(
                    )
                  ],
                ),
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

class CustomButton extends StatefulWidget {
  final Exercise exercise;

  const CustomButton({required this.exercise, required this.callback});

  final VoidCallback callback;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(
          8.0,
        ),
        child: ElevatedButton(
          onPressed: () async {
            if (widget.exercise.solved) {
              return;
            }
            print(widget.exercise.exerciseType);

            switch (widget.exercise.exerciseType.toLowerCase()) {
              case "text":
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CalculateScreen(widget.exercise)),
                );
                widget.callback();
                setState(() {});
                break;
              case "draw":
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WhiteBoardScreen(
                      exercise: widget.exercise,
                    ),
                  ),
                );
                widget.callback();
                setState(() {});
                break;
              case "degree":
                break;
            }
          },
          style: ElevatedButton.styleFrom(
            fixedSize: Size.fromHeight(95.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            primary: widget.exercise.solved ? Colors.blue : Color(0xFFFA6666),
          ),
          child: Text(
            widget.exercise.title,
            style: TextStyle(fontSize: 24),
          ),
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
