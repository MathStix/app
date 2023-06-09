import 'package:flutter/material.dart';
import 'package:nieuw/repositories/shared_preferences_repository.dart';
import 'package:nieuw/screens/ability_screen.dart';
import 'package:nieuw/screens/code_screen.dart';
import '../utils/screen_pusher.dart';

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
                  style: Theme.of(context).textTheme.titleLarge,
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
                    String name = nameController.text.trim();
                    if (_isValidName(name)) {
                      SharedPreferencesRepository.updateProfile();
                      SharedPreferencesRepository.name = name;
                      ScreenPusher.pushScreen(context, CodeScreen(), true);
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Ongeldige naam'),
                          content: Text('Je naam mag alleen letters bevatten.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
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
                        borderRadius: BorderRadius.circular(
                            21.0), // Pas de border radius aan indien nodig
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _isValidName(String name) {
    final RegExp nameRegex = RegExp(r'^[a-zA-Z]+$');
    return nameRegex.hasMatch(name);
  }
}