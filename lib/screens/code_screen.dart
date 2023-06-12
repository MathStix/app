import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nieuw/repositories/game_repository.dart';
import 'package:nieuw/repositories/general_repository.dart';
import 'package:nieuw/repositories/websocket_repository.dart';
import 'package:nieuw/screens/ability_screen.dart';
import 'package:nieuw/screens/overview_screen.dart';
import 'package:nieuw/screens/white_board_screen.dart';
import 'package:nieuw/widgets/background.dart'; // Importeer de GradientBackground-widget
import 'package:nieuw/widgets/custom_timer.dart';
import '../utils/screen_pusher.dart';

class CodeScreen extends StatefulWidget {
  @override
  _CodeScreenState createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {
  final List<TextEditingController> _codeControllers =
  List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  String _errorMessage = '';
  late ValueNotifier<int> seconds;
  late CustomTimer customTimer;

  @override
  void initState() {
    super.initState();
    seconds = ValueNotifier<int>(0);
    customTimer = CustomTimer();
    startTimer();
    print(seconds);
    GeneralRepository.myBoolean.value = true;
  }

  @override
  void dispose() {
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds.value == -10) {
        timer.cancel();
        print("Timer is gestopt");
      } else {
        seconds.value += 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Voer de 4-cijferige code in:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 0; i < 4; i++)
                    Container(
                      alignment: Alignment.center,
                      width: 50.0,
                      child: Stack(
                        children: [
                          TextField(
                            controller: _codeControllers[i],
                            focusNode: _focusNodes[i],
                            maxLength: 1,
                            keyboardType: TextInputType.number,
                            // Alleen numeriek toetsenbord
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _errorMessage = '';
                              });
                              if (value.isNotEmpty && i < 3) {
                                _focusNodes[i + 1].requestFocus();
                              }
                              if (value.isEmpty && i > 0) {
                                _focusNodes[i - 1].requestFocus();
                              }
                            },
                            onSubmitted: (value) {
                              if (value.isEmpty && i > 0) {
                                _focusNodes[i - 1].requestFocus();
                              }
                            },
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Visibility(
                                visible: false,
                                child: Text(
                                  '${_codeControllers[i].text.isNotEmpty ? 1 : 0}/1',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () async {
                  String code = '';
                  for (int i = 0; i < 4; i++) {
                    code += _codeControllers[i].text.toLowerCase();
                  }

                  bool joined = await GameRepository.joinGame(code);
                  if (!joined) {
                    setState(() {
                      _errorMessage = 'Foute code. Probeer het opnieuw.';
                    });
                    return;
                  }
                  bool websocketConnected = await WebsocketRepository.connect();
                  if (websocketConnected) {
                    ScreenPusher.pushScreen(context, OverviewScreen(), true);
                  } else
                    setState(() {
                      _errorMessage = 'Verbinding ging fout';
                    });
                },
                child: Text(
                  'Doorgaan',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                _errorMessage,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}