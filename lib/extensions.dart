import 'package:flutter/material.dart';

import 'consts.dart';
import 'enums.dart';

extension HeightUnitExtension on HeightUnit {
  String name() {
    return this.toString().split('.').last;
  }
}

extension WeightUnitExtension on WeightUnit {
  String name() {
    return this.toString().split('.').last;
  }
}

extension BmiLevelExtension on BmiLevel {
  String label() {
    return Consts.bmiLevels[this.index];
  }
  Color color() {
    return Consts.bmiLevelColors[this.index];
  }
}
