import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:finger_painter/finger_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:nieuw/models/Exercise.dart';
import 'package:nieuw/models/answer.dart';
import 'package:nieuw/repositories/answer_repository.dart';
import 'package:nieuw/repositories/exercise_repository.dart';
import 'package:nieuw/repositories/shared_preferences_repository.dart';
import 'package:nieuw/screens/code_screen.dart';
import 'package:nieuw/utils/color.dart';
import 'package:nieuw/widgets/background.dart';
import 'package:screenshot/screenshot.dart';

class WhiteBoardScreen extends StatefulWidget {
  const WhiteBoardScreen({Key? key, required this.exercise}) : super(key: key);

  final Exercise exercise;

  @override
  State<WhiteBoardScreen> createState() => _WhiteBoardScreenState();
}

class _WhiteBoardScreenState extends State<WhiteBoardScreen> {
  PainterController _controller = PainterController();
  ScreenshotController _screenShotController = ScreenshotController();

  late Color _chosenColor;

  Color _getRandomColor() {
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.orange,
      Colors.green,
      Colors.yellow,
      Colors.purple,
      Colors.pink,
      Colors.black,
    ];
    return colors[DateTime.now().millisecond % colors.length];
  }

  @override
  void initState() {
    super.initState();
    _chosenColor = _getRandomColor();
    _controller = PainterController()
      ..setPenType(PenType.pencil)
      ..setStrokeColor(_chosenColor)
      ..setMinStrokeWidth(2)
      ..setMaxStrokeWidth(2)
      ..setBlurSigma(0.0);
  }

  void send() async {
    Uint8List? image = await _screenShotController.capture();
    if (image == null) {
      print("GING FOUT");
      return;
    }
    var compressedImage = await FlutterImageCompress.compressWithList(image, quality: 30);

    String base64 = base64Encode(compressedImage);
    log(base64);

    Answer answer = Answer(
      texts: [],
      exerciseId: widget.exercise.id,
      teamId: SharedPreferencesRepository.inTeam!,
      photos: [base64],
      canvas: base64,
    );
    await AnswerRepository.getAnswer(answer);

    String receivedLetter = await AnswerRepository.getAnswer(answer);
    if (receivedLetter.isNotEmpty) {
      ExerciseRepository.getExerciseById(widget.exercise.id).solved = true;
      Navigator.pop(context, true);
      print("GOED");
    } else {
      print("FOUT");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Column(
          children: [
            Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          // Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Je tekent nu met ${ColorUtils.colorStringToColor.entries.firstWhere((element) => element.value == _chosenColor).key}",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: send,
                        child: Text('VERSTUUR'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          primary: Color(0xFFFA6666),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 8,
              child: Screenshot(
                controller: _screenShotController,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: Painter(
                        controller: _controller,
                        backgroundColor: Colors.white.withOpacity(0.8),
                        size: Size.infinite,
                        child: Positioned.fill(
                          child: Image.memory(
                            base64Decode(widget.exercise.photo!),
                          ),
                        ),
                        // onDrawingEnded: (data) {
                        //   print(data);
                        // },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
