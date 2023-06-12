import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nieuw/repositories/general_repository.dart';

class CustomTimer extends StatefulWidget {

  @override
  _CustomTimerState createState() => _CustomTimerState();
}

class _CustomTimerState extends State<CustomTimer> {
  Timer? _timer;
  bool _isTimerRunning = true;

  @override
  void initState() {
    super.initState();
    _startTimer();
    stopTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (GeneralRepository.myBoolean.value == false) {
        stopTimer();
        print("Timer is gestopt");
      }
      else {
        setState(() {
          GeneralRepository.seconds.value += 1;
          print("werkt dit?");
        });
      }
    });
  }

  void stopTimer() {
    _isTimerRunning = false;
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String minutes = twoDigits(duration.inMinutes);
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'Tijd op de app: ${_formatDuration(Duration(seconds: GeneralRepository.seconds.value))}',
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
