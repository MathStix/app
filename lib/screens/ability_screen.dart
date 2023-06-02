import 'package:flutter/material.dart';
import 'package:nieuw/screens/overview_screen.dart';

class AbilityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff17174E), Color(0xffB24C5D)],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            )),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 22),
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
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: 34),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Kies je ability',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Deze ability helpt je later in de game en wordt gekozen aan de hand van heel je groep',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomButton(text: 'Freezer'),
                CustomButton(text: 'Guesser'),
                CustomButton(text: 'Blocker'),
                CustomButton(text: 'Quiz Master'),
              ],
            ),
            SizedBox(height: 36),
            Center (
              child: ElevatedButton(
                onPressed: () {
                },
                child: Text('KIES ABILITY'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFFA6666),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;

  const CustomButton({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OverviewScreen()),
          );
        },
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
        style: ElevatedButton.styleFrom(
          fixedSize: Size.fromHeight(95.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          primary: Color(0xFFFA6666),
        ),
      ),
    );
  }
}