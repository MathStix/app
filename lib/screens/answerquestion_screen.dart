import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nieuw/screens/white_board_screen.dart';

class AnswerScreen extends StatelessWidget {
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
                'Vraag x',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Text(
                'Zoek drie vormen van lijnsymmetrie',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: 34),
            Column(
              children: [
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
                SizedBox(height: 60),
                CustomButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WhiteBoardScreen()),
                    );
                  },
                  text: 'Neem foto 1',
                ),
                SizedBox(height: 8),
                CustomButton(
                  onPressed: () {},
                  text: 'Neem foto 2',
                ),
                SizedBox(height: 8),
                CustomButton(
                  onPressed: () {},
                  text: 'Neem foto 3',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        primary: Color(0xFFFA6666),
        minimumSize: Size(double.infinity, 100), // Set the desired button height
      ),
    );
  }
}
