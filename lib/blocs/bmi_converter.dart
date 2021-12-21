import 'package:bmi_calculator/enums.dart';

import '../consts.dart';

abstract class BmiConverter {
  double convertHeight(double value, HeightUnit previousUnit);
  double convertWeight(double value, WeightUnit previousUnit);
}

class MetricConverter extends BmiConverter {
  @override
  double convertHeight(double value, HeightUnit previousUnit) {
    switch (previousUnit) {
      case HeightUnit.m:
        return value;
      case HeightUnit.foot:
        return value / Consts.feetInMeter;
      case HeightUnit.lokiec:
        return value * Consts.metersInLokiec;
    }
  }

  @override
  double convertWeight(double value, WeightUnit previousUnit) {
    switch (previousUnit) {
      case WeightUnit.kg:
        return value;
      case WeightUnit.lb:
        return value / Consts.lbInKg;
      case WeightUnit.funt:
        return value * Consts.kgInFunt;
    }
  }
}

class ImperialConverter extends BmiConverter {
  @override
  double convertHeight(double value, HeightUnit previousUnit) {
    switch(previousUnit) {
      case HeightUnit.m:
        return value * Consts.feetInMeter;
      case HeightUnit.foot:
        return value;
      case HeightUnit.lokiec:
        return value * Consts.feetInLokiec;
    }
  }

  @override
  double convertWeight(double value, WeightUnit previousUnit) {
    switch(previousUnit) {
      case WeightUnit.kg:
        return value * Consts.lbInKg;
      case WeightUnit.lb:
        return value;
      case WeightUnit.funt:
        return value * Consts.lbInFunt;
    }
  }
}

class OldPolishConverter extends BmiConverter {
  @override
  double convertHeight(double value, HeightUnit previousUnit) {
    switch(previousUnit) {
      case HeightUnit.m:
        return value / Consts.metersInLokiec;
      case HeightUnit.foot:
        return value / Consts.feetInLokiec;
      case HeightUnit.lokiec:
        return value;
    }
  }

  @override
  double convertWeight(double value, WeightUnit previousUnit) {
    switch(previousUnit) {
      case WeightUnit.kg:
        return value / Consts.kgInFunt;
      case WeightUnit.lb:
        return value / Consts.lbInFunt;
      case WeightUnit.funt:
        return value;
    }
  }
}