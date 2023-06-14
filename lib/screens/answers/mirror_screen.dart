import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:math' as math;

import 'package:nieuw/models/Exercise.dart';
import 'package:screenshot/screenshot.dart';

import '../../models/answer.dart';
import '../../repositories/answer_repository.dart';
import '../../repositories/exercise_repository.dart';
import '../../repositories/shared_preferences_repository.dart';

class MirrorScreen extends StatefulWidget {
  const MirrorScreen({super.key, required this.exercise});

  final Exercise exercise;

  @override
  State<MirrorScreen> createState() => _MirrorScreenState();
}

class _MirrorScreenState extends State<MirrorScreen> {
  late CameraController controller;
  late List<CameraDescription> _cameras;
  bool _isVisible = true;
  final ScreenshotController _screenShotController = ScreenshotController();


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
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    _cameras = await availableCameras();

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
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return MaterialApp(
      home: Scaffold(
        body: Screenshot(
          controller: _screenShotController,
          child: Column(
            children: [
              SizedBox(height: 44),
              Center(
                child: SelectableText(
                  "Locatie ${widget.exercise.location}",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Row(children: [
                Container(
                  width: 199,
                  alignment: Alignment.bottomLeft,
                  child: CameraPreview(controller),
                ),
                Container(
                  width: 199,
                  alignment: Alignment.bottomRight,
                  child: Transform(
                    origin: const Offset(100, 0),
                    transform: Matrix4.rotationY(math.pi),
                    child: CameraPreview(controller),
                  ),
                ),
              ]),
              Visibility(
                visible: _isVisible,
                child: Row(children: [
                  Container(
                    width: 199,
                    alignment: Alignment.bottomLeft,
                    child: Transform(
                      origin: const Offset(100, 177),
                      transform: Matrix4.rotationX(math.pi),
                      child: CameraPreview(controller),
                    ),
                  ),
                  Container(
                    width: 199,
                    alignment: Alignment.bottomRight,
                    child: Transform(
                      origin: const Offset(100, 177),
                      transform: Matrix4.rotationZ(math.pi),
                      child: CameraPreview(controller),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
        floatingActionButton: Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton.extended(
                onPressed: () {
                  // Handle the first button's onPressed event
                },
                label: const Text('Ga terug'),
                backgroundColor: const Color(0xFFFA6666),
              ),
              const SizedBox(width: 16), // Add some spacing between the buttons
              FloatingActionButton.extended(
                onPressed: () {
                  setState(() {
                    _isVisible = !_isVisible;
                  });
                },
                label: const Text('Wijzig cams'),
                backgroundColor: const Color(0xFFFA6666),
              ),
              const SizedBox(width: 16), // Add some spacing between the buttons
              FloatingActionButton.extended(
                onPressed: send,
                label: const Text('stuur'),
                backgroundColor: const Color(0xFFFA6666),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MathStix',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Hoek berekenen'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
    ));
  }
}
