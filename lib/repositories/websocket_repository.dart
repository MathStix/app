import 'dart:async';
import 'dart:convert';

import 'package:nieuw/repositories/general_repository.dart';
import 'package:nieuw/repositories/shared_preferences_repository.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketRepository {
  static late WebSocketChannel channel;
  static late StreamController<dynamic> _streamController;

  static Future<bool> connect() async {
    Uri webSocketUri = Uri.parse("${GeneralRepository.wsUrl}/websocket");
    try {
      channel = WebSocketChannel.connect(webSocketUri);
      _streamController = StreamController<dynamic>.broadcast();
      // send msg:
      channel.sink.add(jsonEncode({
        "type": "setClientId",
        "deviceId": SharedPreferencesRepository.deviceId,
      }));
      channel.stream.listen((event) {
        print("eventje: " + event);
        _streamController.add(event);
      });
      return true;
    } catch (e) {
      print("Ging fout!");
      print(e);
      return false;
    }
  }

  static Stream<dynamic> get stream => _streamController.stream;
}