import 'package:flutter/material.dart';

class CustomTimer extends StatefulWidget {
  const CustomTimer({super.key, required this.seconds});

  final ValueNotifier<int> seconds;

  @override
  State<CustomTimer> createState() => _CustomTimerState();
}

class _CustomTimerState extends State<CustomTimer> {
  @override
  void initState() {
    super.initState();
    widget.seconds.addListener(() {
      setState(() {});
    });
  }

  String formatDuration(Duration duration) {
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
    return Center(
      child: Text(
        'Tijd op pagina: ${formatDuration(Duration(seconds: widget.seconds.value))}',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
