import 'package:flutter/material.dart';
import 'package:nieuw/screens/ability_screen.dart';

void main() {
  runApp(IdentificationScreen());
}

class IdentificationScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFFA6666),
            onPrimary: Colors.white,
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 26.0,
            ),
          ),
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white, fontSize: 24.0),
          headline6: TextStyle(color: Colors.white),
        ),
      ),
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff17174E), Color(0xffB24C5D)],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              )),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Welkom',
                  style: TextStyle(fontSize: 50.0, color: Colors.white),
                ),
                SizedBox(height: 10.0),
              Text(
              'Voer je naam in om door te gaan',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 30.0),
                TextField(
                  controller: nameController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    errorStyle: TextStyle(color: Colors.red),
                  ),
                ),
            SizedBox(height: 256.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AbilityScreen()),
                );
              },
              child: Text(
                'Verder',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 26.0,
                ),
              ),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(240, 70)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21.0), // Adjust the border radius as needed
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),)
    ,
    );
  }
}