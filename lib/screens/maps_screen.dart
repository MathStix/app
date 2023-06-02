import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nieuw/screens/answerquestion_screen.dart';
import 'package:nieuw/screens/frozen_screen.dart';

class MapsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FrozenScreen()),
      );
    });
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
                'Onderweg naar vraag x',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Text(
                'Nog x meter te gaan',
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
                SizedBox(height: 20),
                Container(
                  height: 300, // Set the desired height
                  width: double.infinity, // Set the desired width
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(37.42796133580664, -122.085749655962),
                      zoom: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}