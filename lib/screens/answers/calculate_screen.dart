import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nieuw/models/Exercise.dart';
import 'package:nieuw/models/answer.dart';
import 'package:nieuw/repositories/answer_repository.dart';
import 'package:nieuw/repositories/exercise_repository.dart';
import 'package:nieuw/repositories/shared_preferences_repository.dart';

class CalculateScreen extends StatefulWidget {
  final Exercise exercise;

  CalculateScreen(this.exercise, {super.key});

  @override
  State<CalculateScreen> createState() => _CalculateScreenState();
}

class _CalculateScreenState extends State<CalculateScreen> {
  TextEditingController nameController = TextEditingController();

  void sendAnswer() async {
    Answer answer = Answer(
      exerciseId: widget.exercise.id,
      texts: [nameController.text],
      photos: [],
      teamId: SharedPreferencesRepository.inTeam!,
      canvas: "",
    );
    String receivedLetter = await AnswerRepository.getAnswer(answer);
    if (receivedLetter.isNotEmpty) {
      ExerciseRepository.getExerciseById(widget.exercise.id).solved = true;
      Navigator.pop(context, true);
      print("GOED");
    } else {
      // Show bottom sheet with error
      showModalBottomSheet(context: context, builder: (context) => Padding(
        padding: const EdgeInsets.all(64.0),
        child: const Text("FOUT"),
      ));

      print("FOUT");
    }
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
        padding: const EdgeInsets.all(16.0),
        child: SizedBox.expand(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Center(
                  child: SelectableText(
                    "Locatie ${widget.exercise.location}",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    widget.exercise.title,
                    style: const TextStyle(fontSize: 26, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      primary: const Color(0xFFFA6666),
                    ),
                    child: Text('POWERUP INZETTEN'),
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: Text(
                    widget.exercise.description,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28.0),
                      border: Border.all(
                        color: const Color(0xFFFA6666),
                        width: 6.0,
                      ),
                    ),
                    child: widget.exercise.photo == null
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Geen plaatje :(",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(28.0),
                            child: Image.memory(
                              base64Decode(widget.exercise.photo!),
                            ),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: nameController,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Antwoord...',
                    labelStyle: const TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: sendAnswer,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      primary: const Color(0xFFFA6666),
                    ),
                    child: Text('VERSTUREN'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
