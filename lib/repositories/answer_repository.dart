import 'dart:convert';

import 'package:nieuw/models/answer.dart';

import 'general_repository.dart';

import 'package:http/http.dart' as http;

class AnswerRepository {
  static Uri postAnswerUri = Uri.parse('${GeneralRepository.baseUrl}/answer');

  static Future<String> getAnswer(Answer answer) async {
    print(jsonEncode(answer.texts));
    var response = await http.post(postAnswerUri,
        headers: <String, String>{
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(<String, String>{
          "texts": jsonEncode(answer.texts),
          "exerciseId": answer.exerciseId,
          "teamId": answer.teamId,
          "photos": answer.photos.toString(),
        }));

    print(response.statusCode);
    if (response.statusCode == 200) {
      String json = response.body;
      Map<String, dynamic> data = jsonDecode(json);
      return "a";
    }
    return '';
  }
}
