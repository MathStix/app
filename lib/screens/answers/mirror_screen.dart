import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:math' as math;

late List<CameraDescription> _cameras;
bool _isVisible = true;

Future<void> main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();
  runApp(const MirrorScreen());
}

/// CameraApp is the Main Application.
class MirrorScreen extends StatefulWidget {
  /// Default Constructor
  const MirrorScreen({super.key});
  @override
  State<MirrorScreen> createState() => _MirrorScreenState();
}
class _MirrorScreenState extends State<MirrorScreen> {
  late CameraController controller;
  @override
  void initState() {
    super.initState();
    initializeCameras();
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

  Future<void> initializeCameras() async {
    _cameras = await availableCameras();
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
        body: Column(
          children: [
            SizedBox(height: 44),
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
        )
    );
  }
}