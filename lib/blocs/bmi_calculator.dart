import '../enums.dart';
import 'bmi_converter.dart';

class BmiCalculator {
  double calculateBmi(double heightValue, HeightUnit heightUnit, double weightValue, WeightUnit weightUnit) {
    if (heightValue <= 0 || weightValue <= 0) {
      return -1;
    }
    MetricConverter metricCalculator = MetricConverter();
    final double heightValueInMetric = metricCalculator.convertHeight(heightValue, heightUnit);
    final double weightValueInMetric = metricCalculator.convertWeight(weightValue, weightUnit);
    return weightValueInMetric / heightValueInMetric / heightValueInMetric;
  }

  BmiLevel getBmiLevel(double bmiValue) {
    final BmiLevel bmiLevel;
    if (bmiValue <= 0) {
      bmiLevel = BmiLevel.empty;
    } else if (bmiValue < 16) {
      bmiLevel = BmiLevel.starvation;
    } else if (bmiValue < 17) {
      bmiLevel = BmiLevel.emaciation;
    } else if (bmiValue < 18.5) {
      bmiLevel = BmiLevel.underweight;
    } else if (bmiValue < 25) {
      bmiLevel = BmiLevel.correct;
    } else if (bmiValue < 30) {
      bmiLevel = BmiLevel.overweight;
    } else if (bmiValue < 35) {
      bmiLevel = BmiLevel.obesityI;
    } else if (bmiValue < 40) {
      bmiLevel = BmiLevel.obesityII;
    } else {
      bmiLevel = BmiLevel.obesityIII;
    }
    return bmiLevel;
  }

}