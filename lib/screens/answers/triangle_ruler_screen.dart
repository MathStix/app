import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:nieuw/models/Exercise.dart';
import 'package:nieuw/models/answer.dart';
import 'package:nieuw/repositories/answer_repository.dart';
import 'package:nieuw/repositories/exercise_repository.dart';
import 'package:nieuw/repositories/shared_preferences_repository.dart';
import 'package:screenshot/screenshot.dart';

class RulerScreen extends StatefulWidget {
  const RulerScreen({super.key, required this.exercise});

  final Exercise exercise;

  @override
  State<RulerScreen> createState() => _RulerScreenState();
}

class _RulerScreenState extends State<RulerScreen> {
  late List<CameraDescription> _cameras;

  late ValueNotifier<Matrix4> notifier;
  late CameraController controller;

  final ScreenshotController _screenShotController = ScreenshotController();

  double _transparency = 100;

  bool _paused = false;

  void togglePause() {
    setState(() {
      _paused = !_paused;
      if (_paused) {
        controller.pausePreview();
      } else {
        controller.resumePreview();
      }
    });
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

  void load() async {
    _cameras = await availableCameras();

    notifier = ValueNotifier(Matrix4.identity());
    controller = CameraController(_cameras[0], ResolutionPreset.max);

    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 16.0,
              ),
              child: Column(
                children: [
                  Slider(
                    value: _transparency,
                    max: 100,
                    min: 0,
                    onChanged: (newValue) => {
                      setState(
                        () {
                          _transparency = newValue;
                        },
                      )
                    },
                  ),
                  Text(
                    widget.exercise.title,
                    style: const TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                  Text(
                    widget.exercise.description,
                    style: const TextStyle(
                      fontSize: 12.0,
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
            ),
            Expanded(
              child: Screenshot(
                controller: _screenShotController,
                child: Stack(
                  children: [
                    SizedBox.expand(
                      child: !controller.value.isInitialized
                          ? Container()
                          : CameraPreview(controller),
                    ),
                    SizedBox.expand(
                      child: MatrixGestureDetector(
                        onMatrixUpdate: (m, tm, sm, rm) {
                          setState(() {
                            notifier.value = m;
                          });
                        },
                        child: Transform(
                          transform: notifier.value,
                          child: Opacity(
                            opacity: _transparency / 100,
                            child: const Image(
                              image: AssetImage('assets/geodriehoek.png'),
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: togglePause,
        child: Icon(
          _paused ? Icons.play_arrow : Icons.pause,
        ),
      ),
    );
  }
}
