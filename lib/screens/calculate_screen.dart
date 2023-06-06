import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nieuw/screens/answerquestion_screen.dart';

class CalculateScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();

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
            SizedBox(height: 30),
            Center(
              child: Text(
                'Vraagnaam',
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text('POWERUP INZETTEN'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  primary: Color(0xFFFA6666),
                ),
              ),
            ),
            SizedBox(height: 24),
            Center(
              child: Text(
                'Vraagstelling',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28.0),
                  border: Border.all(
                    color: Color(0xFFFA6666),
                    width: 6.0,
                  ),
                ),
                child: Image.asset(
                  'assets/questionexample.png',
                  height: 160,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: nameController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Antwoord...',
                labelStyle: TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
