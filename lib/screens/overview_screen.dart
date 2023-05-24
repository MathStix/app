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
            SizedBox(height: 24),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              mainAxisSpacing: 22.0,
              crossAxisSpacing: 22.0,
              children: [
                CustomFigure(),
                CustomFigure(),
                CustomFigure(),
                CustomFigure(),
                CustomFigure(),
                CustomFigure(),
              ],
            ),
            SizedBox(height: 36),
            Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
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
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}