import 'package:flutter/material.dart';

abstract class Consts{
  static const double feetInMeter = 3.28;
  static const double lbInKg = 0.45359237;

  static const List<String> bmiLevels = [
    "Starvation",
    "Emaciation",
    "Underweight",
    "Correct weight!",
    "Overweight",
    "Obesity (level I)",
    "Obesity (level II)",
    "Obesity (level III)",
    ""
  ];

  static const List<Color> bmiLevelColors = [
    Colors.blue,
    Colors.lightBlueAccent,
    Colors.greenAccent,
    Colors.green,
    Colors.orangeAccent,
    Colors.orange,
    Colors.redAccent,
    Colors.red,
    Colors.grey,
  ];
}