

import 'package:flutter/material.dart';
import 'package:music_player/screens/player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Player(),
    );
  }
}
