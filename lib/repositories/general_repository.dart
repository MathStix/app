import 'package:flutter/material.dart';

class GeneralRepository {

  // static String baseUrl = "http://paste.kyllian.nl:3000";
  // static String wsUrl = "ws://paste.kyllian.nl:3000";
  static String baseUrl = "http://145.93.48.221:3000";
  static String wsUrl = "ws://145.93.48.221:3000";
  static ValueNotifier<int> seconds = ValueNotifier<int>(0);
  static ValueNotifier<bool> myBoolean = ValueNotifier<bool>(true);

}