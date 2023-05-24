import 'dart:typed_data';

import 'package:color_parser/color_parser.dart';
import 'package:finger_painter/finger_painter.dart';
import 'package:flutter/material.dart';
import 'package:nieuw/utils/color.dart';
import 'package:nieuw/widgets/background.dart';

class WhiteBoardScreen extends StatefulWidget {
  const WhiteBoardScreen({Key? key}) : super(key: key);

  @override
  State<WhiteBoardScreen> createState() => _WhiteBoardScreenState();
}

class _WhiteBoardScreenState extends State<WhiteBoardScreen> {
  PainterController _controller = PainterController();

  late Color _chosenColor;

  Color _getRandomColor() {
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.orange,
      Colors.green,
      Colors.yellow,
      Colors.purple,
      Colors.pink,
      Colors.black,
    ];
    return colors[DateTime.now().millisecond % colors.length];
  }

  @override
  void initState() {
    super.initState();
    _chosenColor = _getRandomColor();
    _controller = PainterController()
      ..setPenType(PenType.pencil)
      ..setStrokeColor(_chosenColor)
      ..setMinStrokeWidth(2)
      ..setMaxStrokeWidth(2)
      ..setBlurSigma(0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Column(
          children: [
            Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          print('back');
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Je tekent nu met ${ColorUtils.colorStringToColor.entries.firstWhere((element) => element.value == _chosenColor).key}",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 8,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: Painter(
                      controller: _controller,
                      backgroundColor: Colors.white.withOpacity(0.8),
                      size: Size.infinite,
                      child: Positioned.fill(
                        child: Image.network(
                          "https://www.wereldwonderen.com/cache/a/eiffeltoren_1.jpg",
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      // onDrawingEnded: (data) {
                      //   print(data);
                      // },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
