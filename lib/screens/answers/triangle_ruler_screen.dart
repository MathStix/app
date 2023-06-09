import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';

class RulerScreen extends StatefulWidget {
  const RulerScreen({super.key});

  @override
  State<RulerScreen> createState() => _RulerScreenState();
}

class _RulerScreenState extends State<RulerScreen> {
  late List<CameraDescription> _cameras;

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

