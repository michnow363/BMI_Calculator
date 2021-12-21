import 'package:bmi_calculator/blocs/bmi_calculator.dart';
import 'package:bmi_calculator/blocs/bmi_converter.dart';
import 'package:bmi_calculator/enums.dart';
import 'package:mockito/mockito.dart';

class MockBmiCalculator extends Mock implements BmiCalculator {
  @override
  double calculateBmi(double heightValue, HeightUnit heightUnit,
      double weightValue, WeightUnit weightUnit) {
    return 20.0;
  }

  @override
  BmiLevel getBmiLevel(double bmiValue) {
    return BmiLevel.correct;
  }
}

class MockMetricConverter extends Mock implements MetricConverter {
  @override
  double convertHeight(double value, HeightUnit previousUnit) {
    return 1;
  }

  @override
  double convertWeight(double value, WeightUnit previousUnit) {
    return 1;
  }
}

class MockImperialConverter extends Mock implements ImperialConverter {
  @override
  double convertHeight(double value, HeightUnit previousUnit) {
    return 2;
  }

  @override
  double convertWeight(double value, WeightUnit previousUnit) {
    return 2;
  }
}

class MockOldPolishConverter extends Mock implements OldPolishConverter {
  @override
  double convertHeight(double value, HeightUnit previousUnit) {
    return 3;
  }

  @override
  double convertWeight(double value, WeightUnit previousUnit) {
    return 3;
  }
}