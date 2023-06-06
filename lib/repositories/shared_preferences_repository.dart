import 'package:device_info_plus/device_info_plus.dart';
import 'package:nieuw/repositories/player_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class SharedPreferencesRepository {

  static String? inTeam;

  static String? _deviceId;
  static String? _name;

  static String? get deviceId => _deviceId;
  static String? get name => _name;

  static set name(String? name) {
    _name = name;
    _sharedPreferences!.setString('name', name!);
  }

  static bool get isKnown => _name != null && _name!.isNotEmpty;

  static SharedPreferences? _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (kIsWeb) {
      WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;

      _deviceId = webBrowserInfo.userAgent;
    } else {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      _deviceId = androidInfo.id;
    }

    _name = _sharedPreferences!.getString('name');

    print("Device id: $_deviceId");
    print("Name: $_name");
    print(SharedPreferencesRepository.isKnown);
  }

  static Future<void> updateProfile() async {
    PlayerRepository.updateProfile(_deviceId!, _name!);
  }
}