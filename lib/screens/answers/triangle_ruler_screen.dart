import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:flutter/services.dart';

late List<CameraDescription> _cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _cameras = await availableCameras();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RulerScreen(),
    );
  }
}

class RulerScreen extends StatefulWidget {
  const RulerScreen({super.key});

  @override
  State<RulerScreen> createState() => _RulerScreenState();
}

class _RulerScreenState extends State<RulerScreen> {
  late ValueNotifier<Matrix4> notifier;
  late CameraController controller;

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

  @override
  void initState() {
    super.initState();

    notifier = ValueNotifier(Matrix4.identity());
    controller = CameraController(_cameras[0], ResolutionPreset.max);

    controller.initialize().then((_) {
      if (!mounted) {
        print("Not mounted1");
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print("ging fout!");
            // Handle access errors here.
            break;
          default:
            print("ging fout! ${e.code}");
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Geodriehoek POC"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Slider(
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
          ),
          Expanded(
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
        ],
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

