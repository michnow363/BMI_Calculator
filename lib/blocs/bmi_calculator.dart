import 'package:bmi_calculator/enums.dart';

import '../consts.dart';

abstract class BmiCalculator {
  static double calculateBmi(double heightValue, HeightUnit heightUnit, double weightValue, WeightUnit weightUnit) {
    if (heightValue <= 0 || weightValue <= 0) {
      return -1;
    }
    MetricCalculator metricCalculator = MetricCalculator();
    final double heightValueInMetric = metricCalculator.convertHeight(heightValue, heightUnit);
    final double weightValueInMetric = metricCalculator.convertWeight(weightValue, weightUnit);
    return weightValueInMetric / heightValueInMetric / heightValueInMetric;
  }

  double convertHeight(double value, HeightUnit previousUnit);
  double convertWeight(double value, WeightUnit previousUnit);
}

class MetricCalculator extends BmiCalculator {
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

class ImperialCalculator extends BmiCalculator {
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

class OldPolishCalculator extends BmiCalculator {
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