import 'package:bmi_calculator/blocs/bmi_calculator.dart';
import 'package:bmi_calculator/blocs/bmi_converter.dart';
import 'package:bmi_calculator/consts.dart';
import 'package:bmi_calculator/enums.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final _testHeight = 1.75;
  final _testWeight = 76.9;
  final _testBmi = _testWeight / _testHeight / _testHeight;
  test('Metric Calculator tests', () {
    final calculator = MetricConverter();
    var value = calculator.convertHeight(_testHeight, HeightUnit.m);
    expect(value, _testHeight);
    value = calculator.convertHeight(_testHeight, HeightUnit.foot);
    expect(value, _testHeight / Consts.feetInMeter);
    value = calculator.convertHeight(_testHeight, HeightUnit.lokiec);
    expect(value, _testHeight * Consts.metersInLokiec);

    value = calculator.convertWeight(_testWeight, WeightUnit.kg);
    expect(value, _testWeight);
    value = calculator.convertWeight(_testWeight, WeightUnit.lb);
    expect(value, _testWeight / Consts.lbInKg);
    value = calculator.convertWeight(_testWeight, WeightUnit.funt);
    expect(value, _testWeight * Consts.kgInFunt);
  });
  test('Imperial Calculator tests', () {
    final calculator = ImperialConverter();
    var value = calculator.convertHeight(_testHeight, HeightUnit.m);
    expect(value, _testHeight * Consts.feetInMeter);
    value = calculator.convertHeight(_testHeight, HeightUnit.foot);
    expect(value, _testHeight);
    value = calculator.convertHeight(_testHeight, HeightUnit.lokiec);
    expect(value, _testHeight * Consts.feetInLokiec);

    value = calculator.convertWeight(_testWeight, WeightUnit.kg);
    expect(value, _testWeight * Consts.lbInKg);
    value = calculator.convertWeight(_testWeight, WeightUnit.lb);
    expect(value, _testWeight);
    value = calculator.convertWeight(_testWeight, WeightUnit.funt);
    expect(value, _testWeight * Consts.lbInFunt);
  });
  test('Old Polish Calculator tests', () {
    final calculator = OldPolishConverter();
    var value = calculator.convertHeight(_testHeight, HeightUnit.m);
    expect(value, _testHeight / Consts.metersInLokiec);
    value = calculator.convertHeight(_testHeight, HeightUnit.foot);
    expect(value, _testHeight / Consts.feetInLokiec);
    value = calculator.convertHeight(_testHeight, HeightUnit.lokiec);
    expect(value, _testHeight);

    value = calculator.convertWeight(_testWeight, WeightUnit.kg);
    expect(value, _testWeight / Consts.kgInFunt);
    value = calculator.convertWeight(_testWeight, WeightUnit.lb);
    expect(value, _testWeight / Consts.lbInFunt);
    value = calculator.convertWeight(_testWeight, WeightUnit.funt);
    expect(value, _testWeight);
  });
  test('Bmi Calculator tests', () {
    var calculator = BmiCalculator();
    var value = calculator.calculateBmi(_testHeight, HeightUnit.m, _testWeight, WeightUnit.kg);
    expect(value, _testBmi);
    value = calculator.calculateBmi(_testHeight, HeightUnit.m, _testWeight * Consts.lbInKg, WeightUnit.lb);
    expect(value, _testBmi);
    value = calculator.calculateBmi(_testHeight, HeightUnit.m, _testWeight / Consts.kgInFunt, WeightUnit.funt);
    expect(value, _testBmi);
    value = calculator.calculateBmi(_testHeight * Consts.feetInMeter, HeightUnit.foot, _testWeight, WeightUnit.kg);
    expect(value, _testBmi);
    value = calculator.calculateBmi(_testHeight * Consts.feetInMeter, HeightUnit.foot, _testWeight * Consts.lbInKg, WeightUnit.lb);
    expect(value, _testBmi);
    value = calculator.calculateBmi(_testHeight * Consts.feetInMeter, HeightUnit.foot, _testWeight / Consts.kgInFunt, WeightUnit.funt);
    expect(value, _testBmi);
    value = calculator.calculateBmi(_testHeight / Consts.metersInLokiec, HeightUnit.lokiec, _testWeight, WeightUnit.kg);
    expect(value, _testBmi);
    value = calculator.calculateBmi(_testHeight / Consts.metersInLokiec, HeightUnit.lokiec, _testWeight * Consts.lbInKg, WeightUnit.lb);
    expect(value, _testBmi);
    value = calculator.calculateBmi(_testHeight / Consts.metersInLokiec, HeightUnit.lokiec, _testWeight / Consts.kgInFunt, WeightUnit.funt);
    expect(value, _testBmi);
  });
  test('Bmi Calculator tests', () {
    var calculator = BmiCalculator();
    var bmiLevel = calculator.getBmiLevel(-9);
    expect(bmiLevel, BmiLevel.empty);
    bmiLevel = calculator.getBmiLevel(0);
    expect(bmiLevel, BmiLevel.empty);
    bmiLevel = calculator.getBmiLevel(5);
    expect(bmiLevel, BmiLevel.starvation);
    bmiLevel = calculator.getBmiLevel(16);
    expect(bmiLevel, BmiLevel.emaciation);
    bmiLevel = calculator.getBmiLevel(16.5);
    expect(bmiLevel, BmiLevel.emaciation);
    bmiLevel = calculator.getBmiLevel(17);
    expect(bmiLevel, BmiLevel.underweight);
    bmiLevel = calculator.getBmiLevel(17.9);
    expect(bmiLevel, BmiLevel.underweight);
    bmiLevel = calculator.getBmiLevel(18.5);
    expect(bmiLevel, BmiLevel.correct);
    bmiLevel = calculator.getBmiLevel(22);
    expect(bmiLevel, BmiLevel.correct);
    bmiLevel = calculator.getBmiLevel(25);
    expect(bmiLevel, BmiLevel.overweight);
    bmiLevel = calculator.getBmiLevel(27);
    expect(bmiLevel, BmiLevel.overweight);
    bmiLevel = calculator.getBmiLevel(30);
    expect(bmiLevel, BmiLevel.obesityI);
    bmiLevel = calculator.getBmiLevel(33);
    expect(bmiLevel, BmiLevel.obesityI);
    bmiLevel = calculator.getBmiLevel(35);
    expect(bmiLevel, BmiLevel.obesityII);
    bmiLevel = calculator.getBmiLevel(37);
    expect(bmiLevel, BmiLevel.obesityII);
    bmiLevel = calculator.getBmiLevel(40);
    expect(bmiLevel, BmiLevel.obesityIII);
    bmiLevel = calculator.getBmiLevel(44);
    expect(bmiLevel, BmiLevel.obesityIII);
  });
}