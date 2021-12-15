import 'package:flutter/material.dart';

import 'consts.dart';
import 'enums.dart';

extension HeightUnitExtension on HeightUnit {
  UnitSystem unitSystem() {
    switch(this) {
      case HeightUnit.m:
        return UnitSystem.metric;
      case HeightUnit.foot:
        return UnitSystem.imperial;
      case HeightUnit.lokiec:
        return UnitSystem.oldPolish;
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
      case WeightUnit.funt:
        return UnitSystem.oldPolish;
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
