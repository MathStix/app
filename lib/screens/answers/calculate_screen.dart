import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nieuw/models/Exercise.dart';
import 'package:nieuw/models/answer.dart';
import 'package:nieuw/repositories/answer_repository.dart';
import 'package:nieuw/repositories/shared_preferences_repository.dart';

class CalculateScreen extends StatelessWidget {
  final Exercise exercise;

  CalculateScreen(this.exercise, {super.key});

  TextEditingController nameController = TextEditingController();

  void sendAnswer() async {
    Answer answer = Answer(
      exerciseId: exercise.id,
      texts: [nameController.text],
      photos: [],
      teamId: SharedPreferencesRepository.inTeam!,
      canvas: "",
    );
    String receivedLetter = await AnswerRepository.getAnswer(answer);
    if (receivedLetter.isNotEmpty) {
      print("GOED");
    } else {
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Center(
                child: Text(
                  exercise.title,
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
                  exercise.description,
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
                  child: exercise.photo == null
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Geen plaatje :(",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : Image.memory(base64Decode(exercise.photo!)),
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
    );
  }
}
