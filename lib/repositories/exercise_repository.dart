import 'dart:convert';

import 'package:nieuw/models/Exercise.dart';
import 'package:nieuw/repositories/general_repository.dart';
import 'package:http/http.dart' as http;

class ExerciseRepository {
  static Uri getExercisesUri = Uri.parse('${GeneralRepository.baseUrl}/team');

  Future<List<Exercise>> getExercises(String teamId) async {
    List<Exercise> exercises = [];
    Uri getExercisesUri =
        Uri.parse('${GeneralRepository.baseUrl}/team/${teamId}');
    print(getExercisesUri);
    var response = await http.get(getExercisesUri, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    print("1123456");
    if (response.statusCode == 200) {
      print("08743087578");
      String json = response.body;
      Map<String, dynamic> data = jsonDecode(json);
      for (var item in data['unlockedExerciseIds']) {
        exercises.add(Exercise.fromJson(item));
      }
    }
    print("Codeeee: ${response.statusCode}");
    return exercises;
  }
}
