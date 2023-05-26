import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nieuw/screens/answerquestion_screen.dart';
import 'package:nieuw/screens/home_screen.dart';
import 'package:nieuw/screens/identification_screen.dart';
import 'package:nieuw/screens/maps_screen.dart';
import 'package:nieuw/screens/question_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => IdentificationScreen(),
        ),
      );
    });
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
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/Group 63.png'),
            SizedBox(height: 20),
            Text('MathStix', style: TextStyle(
              color: Colors.white,
              fontSize: 50,
            ),)
          ],
        ),
      ),
    );
  }
}
