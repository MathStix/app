import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nieuw/repositories/shared_preferences_repository.dart';
import 'package:nieuw/repositories/websocket_repository.dart';
import 'package:nieuw/screens/maps_screen.dart';
import 'package:nieuw/screens/question_screen.dart';

import '../repositories/general_repository.dart';
import '../widgets/custom_timer.dart';

class OverviewScreen extends StatefulWidget {
  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  late CustomTimer customTimer;


  @override
  void initState() {
    super.initState();
    GeneralRepository.myBoolean.value = true;
    customTimer = CustomTimer();

    print(GeneralRepository.seconds.value);
    // We assume the websocket connection is OK
    WebsocketRepository.stream.listen((event) {
      Map<String, dynamic> json = jsonDecode(event);

      print(json);
      if (json['message'] == "startGame") {
        SharedPreferencesRepository.inTeam = json['teamId'];
        // TODO: Navigate to question screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QuestionScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff17174E), Color(0xffB24C5D)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Center(
              child: Text(
                'Even geduld...',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Text(
                'Er zitten x mensen in de lobby',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            SizedBox(height: 34),
            Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Gekozen ability: Freezer',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuestionScreen()),
                    );
                  },
                  child: Text('WIJZIG'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    primary: Color(0xFFFA6666),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Met jou aan het wachten:',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
            SizedBox(height: 24),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              children: [
                // CustomFigure(),
                // CustomFigure(),
                // CustomFigure(),
                // CustomFigure(),
                // CustomFigure(),
                // CustomFigure(),
              ],
            ),
            SizedBox(height: 36),
            Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),

            CustomTimer(
            ),
          ],
        ),
      ),
    );
  }
}

class CustomFigure extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Naam',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
