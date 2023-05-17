import 'package:flutter/material.dart';

class OverviewScreen extends StatelessWidget {
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
            SizedBox(height: 22),
            Center(
              child: Text(
                'Even geduld...',
                style: TextStyle(fontSize: 38, color: Colors.white),
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
            SizedBox(height: 36),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                },
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
                label: Text(
                  '',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(60, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  primary: Color(0xFFFA6666),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}