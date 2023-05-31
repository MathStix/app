import 'dart:convert';
import 'dart:math';

import 'package:nieuw/repositories/general_repository.dart';
import 'package:http/http.dart' as http;

class GameRepository {

  static final String _deviceId = getRandomString(10);
  static String? _chosenGameId;

  static Uri addPlayerUri = Uri.parse('${GeneralRepository.baseUrl}/addPlayer');

  static Future<bool> joinGame(String code) async {
    http.Response response = await http.post(
      addPlayerUri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'deviceId': "123456789",
        'gameCode': code,
      }),
    );

    Map<String, dynamic> json = jsonDecode(response.body);
    _chosenGameId = json['_id'];

    return response.statusCode == 200;
  }


  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static final Random _rnd = Random();

  static String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

}