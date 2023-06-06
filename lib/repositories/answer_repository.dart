import 'dart:convert';

import 'package:nieuw/models/answer.dart';
import 'package:nieuw/repositories/game_repository.dart';

import 'general_repository.dart';

import 'package:http/http.dart' as http;

class AnswerRepository {
  static Uri postAnswerUri = Uri.parse('${GeneralRepository.baseUrl}/answer');

  static Future<String> getAnswer(Answer answer) async {
    print("Print ${answer.teamId}");
    print("game id  ${GameRepository.chosenGameId}");
    var response = await http.post(
      postAnswerUri,
      headers: <String, String>{
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode(
        <String, String>{
          "texts": jsonEncode(answer.texts),
          "gameId": GameRepository.chosenGameId!,
          "exerciseId": answer.exerciseId,
          "teamId": answer.teamId,
          "photos": answer.photos.toString(),
        },
      ),
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      String json = response.body;
      print(json);
      Map<String, dynamic> data = jsonDecode(json);
      return "a";
    }
    print("error");
    return '';
  }
}
