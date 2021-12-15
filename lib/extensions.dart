
import 'package:flutter/material.dart';

import 'consts.dart';
import 'enums.dart';

extension BmiLevelExtension on BmiLevel {
  String label() {
    return Consts.bmiLevels[this.index];
  }
  Color color() {
    return Consts.bmiLevelColors[this.index];
  }
}
