import 'package:flutter/material.dart';

import 'consts.dart';
import 'enums.dart';

extension HeightUnitExtension on HeightUnit {
  UnitSystem unitSystem() {
    switch(this) {
      case HeightUnit.m:
        return UnitSystem.metric;
      case HeightUnit.feet:
        return UnitSystem.imperial;
    }
  }
}

extension WeightUnitExtension on WeightUnit {
  UnitSystem unitSystem() {
    switch(this) {
      case WeightUnit.kg:
        return UnitSystem.metric;
      case WeightUnit.lb:
        return UnitSystem.imperial;
    }
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
