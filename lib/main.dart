import 'package:flutter/material.dart';
import 'package:mario/mario_animation.dart';
import 'package:mario/mario_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mario',
      theme: ThemeData(),
      home: const MarioAnimation(),
    );
  }
}
