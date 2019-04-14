import 'dart:async';

import 'package:flutter/material.dart';

class ColorRadio extends StatefulWidget {
  static List<Color> colorTable = [
    Colors.blue.shade300,
    Colors.red.shade300,
    Colors.amber.shade300,
    Colors.purpleAccent.shade400
  ];

  @override
  ColorRadioState createState() => ColorRadioState();
}

class ColorRadioState extends State<ColorRadio> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: _colorListItem,
      ),
    );
  }
}

