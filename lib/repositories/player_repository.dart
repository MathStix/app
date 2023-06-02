import 'dart:convert';

import 'general_repository.dart';

import 'package:http/http.dart' as http;

class PlayerRepository {
  static Uri playerUri = Uri.parse('${GeneralRepository.baseUrl}/player');

  static Future<void> updateProfile(String deviceId, String name) async {
    print("Profiel updaten");

    await http.post(
      playerUri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'deviceId': deviceId,
        'name': name,
      }),
    );
    print("Profiel updaten 2");
    return;
  }
}
