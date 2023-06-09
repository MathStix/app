import 'package:flutter/material.dart';

class GeneralRepository {

  // static String baseUrl = "http://paste.kyllian.nl:3000";
  // static String wsUrl = "ws://paste.kyllian.nl:3000";
  static String baseUrl = "http://192.168.137.23:3000";
  static String wsUrl = "ws://192.168.137.23:3000";
  static ValueNotifier<int> seconds = ValueNotifier<int>(0);
}