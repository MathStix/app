import 'dart:convert';

import 'package:nieuw/models/Exercise.dart';
import 'package:nieuw/repositories/general_repository.dart';
import 'package:http/http.dart' as http;

class ExerciseRepository {
  static Uri getExercisesUri = Uri.parse('${GeneralRepository.baseUrl}/team');

  static List<Exercise> exercises = [];

  Future<List<Exercise>> getExercises(String teamId) async {
    Uri getExercisesUri =
        Uri.parse('${GeneralRepository.baseUrl}/team/${teamId}');
    print(getExercisesUri);
    var response = await http.get(getExercisesUri, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    if (response.statusCode == 200) {
      String json = response.body;
      Map<String, dynamic> data = jsonDecode(json);
      for (var item in data['unlockedExerciseIds']) {
        exercises.add(Exercise.fromJson(item));
      }
    }
    return exercises;
  }

  static Exercise getExerciseById(String id) {
    return exercises.firstWhere((element) => element.id == id);
  }
}
