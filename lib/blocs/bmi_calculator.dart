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
      case HeightUnit.feet:
        return value / Consts.feetInMeter;
    }
  }

  @override
  double convertWeight(double value, WeightUnit previousUnit) {
    switch (previousUnit) {
      case WeightUnit.kg:
        return value;
      case WeightUnit.lb:
        return value / Consts.lbInKg;
    }
  }
}

class ImperialCalculator extends BmiCalculator {
  @override
  double convertHeight(double value, HeightUnit previousUnit) {
    switch(previousUnit) {
      case HeightUnit.m:
        return value * Consts.feetInMeter;
      case HeightUnit.feet:
        return value;
    }
  }

  @override
  double convertWeight(double value, WeightUnit previousUnit) {
    switch(previousUnit) {
      case WeightUnit.kg:
        return value * Consts.lbInKg;
      case WeightUnit.lb:
        return value;
    }
  }
}