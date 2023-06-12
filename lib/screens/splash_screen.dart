import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nieuw/repositories/shared_preferences_repository.dart';
import 'package:nieuw/screens/answers/mirror_screen.dart';
import 'package:nieuw/screens/answers/triangle_ruler_screen.dart';
import 'package:nieuw/screens/code_screen.dart';
import 'package:nieuw/screens/identification_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    load();
  }

  void load() async {
    await SharedPreferencesRepository.init();

    if (SharedPreferencesRepository.isKnown) {
      SharedPreferencesRepository.updateProfile();
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => SharedPreferencesRepository.isKnown
            ? CodeScreen()
            : IdentificationScreen(),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xff16164D), Color(0xffFA6666)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/Group 63.png'),
            SizedBox(height: 20),
            Text(
              'MathStix',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
