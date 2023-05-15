import 'package:flutter/material.dart';
import 'package:nieuw/screens/home_screen.dart';

import '../utils/screen_pusher.dart';

class CodeScreen extends StatefulWidget {
  @override
  _CodeScreenState createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {
  final List<TextEditingController> _codeControllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  String _errorMessage = '';

  @override
  void dispose() {
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Code Page'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Voer de 4-letterige code in:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < 4; i++)
                  Container(
                    width: 50.0,
                    child: Stack(
                      children: [
                        TextField(
                          controller: _codeControllers[i],
                          focusNode: _focusNodes[i],
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _errorMessage = '';
                            });
                            if (value.isNotEmpty && i < 3) {
                              _focusNodes[i + 1].requestFocus();
                            }
                            if (value.isEmpty && i > 0){
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
              onPressed: () {
                String code = '';
                for (int i = 0; i < 4; i++) {
                  code += _codeControllers[i].text.toLowerCase();
                }

                if (code == 'abcd') {
                  ScreenPusher.pushScreen(context, HomeScreen(), true);
                } else {
                  setState(() {
                    _errorMessage = 'Foute code. Probeer het opnieuw.';
                  });
                }
              },
              child: Text('Doorgaan'),
            ),
            SizedBox(height: 10.0),
            Text(
              _errorMessage,
              style: TextStyle(
                color: Colors.red,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}