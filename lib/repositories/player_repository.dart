import 'dart:convert';

import 'general_repository.dart';

import 'package:http/http.dart' as http;

class PlayerRepository {

  static Uri playerUri = Uri.parse('${GeneralRepository.baseUrl}/player');

  static Future<void> updateProfile(String deviceId, String name) async {
    http.Response response = await http.post(
      playerUri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'deviceId': deviceId,
        'gameCode': name,
      }),
    );

    Map<String, dynamic> json = jsonDecode(response.body);
    return;
  }


}