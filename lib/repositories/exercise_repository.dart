import 'dart:convert';

import 'package:nieuw/models/Exercise.dart';
import 'package:nieuw/repositories/general_repository.dart';
import 'package:http/http.dart' as http;

class ExerciseRepository {

  static Uri getExercisesUri = Uri.parse('${GeneralRepository.baseUrl}/team');


  Future<List<Exercise>> getExercises(String teamId) async {
    print('hoi');
    List<Exercise> exercises = [];
    Uri getExercisesUri = Uri.parse('${GeneralRepository.baseUrl}/team/${teamId}');
    print(getExercisesUri);
    print("hoi 2.0");
    var response = await http.get(getExercisesUri, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    print("hoi 3.0");
    if (response.statusCode == 200) {
      print("hoi 4.0");
      String json = response.body;
      print(json);
      Map<String, dynamic> data = jsonDecode(json);
      print(data);
      for (var item in data['unlockedExerciseIds']) {
        print("hallo wereld");
        exercises.add(Exercise.fromJson(item));
      }
    }
    print(getExercisesUri);
    print(response.statusCode);
    return exercises;
  }

}