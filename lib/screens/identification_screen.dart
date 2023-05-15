import 'package:flutter/material.dart';

class Identification extends StatelessWidget{
  const Identification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My App'),
      ),
      body: const Center(
        child: Text('Welcome to my app'),
      ),
    );
  }
}
