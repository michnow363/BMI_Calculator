import 'package:bmi_calculator/blocs/bmi_state.dart';
import 'package:bmi_calculator/consts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bmi_calculator/extensions.dart';
import '../enums.dart';
import 'bmi_event.dart';

class BmiBloc extends Bloc<BmiEvent, BmiState> {
  int _heightIndex;
  int _weightIndex;
  double heightValue;
  double weightValue;
  String heightUnit;
  String weightUnit;

  BmiBloc()
      : _heightIndex = 0,
        _weightIndex = 0,
        heightValue = 0.0,
        weightValue = 0.0,
        heightUnit = HeightUnit.values[0].name(),
        weightUnit = WeightUnit.values[0].name(),
        super(
          ChangeUnitState(
            HeightUnit.values[0].name(),
            WeightUnit.values[0].name(),
            0,
            0,
            0,
          ),
        ) {
    on<ChangeUnitEvent>(
      (event, emit) {
        switch (event.valueType) {
          case ValueType.height:
            _heightIndex = _nextHeightIndex(HeightUnit.values.length);
            final unit = HeightUnit.values[_heightIndex];
            heightUnit = unit.name();
            switch (unit) {
              case HeightUnit.m:
                heightValue = convertToM(heightValue);
                break;
              case HeightUnit.feet:
                heightValue = convertToFeet(heightValue);
                break;
            }
            emit(ChangeUnitState(
                heightUnit, weightUnit, heightValue, weightValue, 0));
            break;
          case ValueType.weight:
            _weightIndex = _nextWeightIndex(WeightUnit.values.length);
            final unit = WeightUnit.values[_weightIndex];
            weightUnit = unit.name();
            switch (unit) {
              case WeightUnit.kg:
                weightValue = convertToKg(weightValue);
                break;
              case WeightUnit.lb:
                weightValue = convertToLb(weightValue);
                break;
            }
            emit(ChangeUnitState(
                heightUnit, weightUnit, heightValue, weightValue, 0));
            break;
        }
      },
    );
    on<ChangeValueEvent>(
      (event, emit) {
        switch (event.valueType) {
          case ValueType.height:
            heightValue = event.newValue;
            emit(ChangeUnitState(
                heightUnit, weightUnit, heightValue, weightValue, 0));
            break;
          case ValueType.weight:
            weightValue = event.newValue;
            emit(ChangeUnitState(
                heightUnit, weightUnit, heightValue, weightValue, 0));
            break;
        }
      },
    );
    on<CalculateBmiEvent>((event, emit) {
      final double heightValueInMetric = convertToM(heightValue);
      final double weightValueInMetric = convertToKg(weightValue);
      emit(ChangeUnitState(
        heightUnit,
        weightUnit,
        heightValue,
        weightValue,
        calculateBmi(heightValueInMetric, weightValueInMetric),
      ));
    });
  }

  int _nextHeightIndex(int numberOfValues) {
    ++_heightIndex;
    return _heightIndex % numberOfValues;
  }

  int _nextWeightIndex(int numberOfValues) {
    ++_weightIndex;
    return _weightIndex % numberOfValues;
  }

  double convertToM(double value) {
    return HeightUnit.values[_heightIndex] == HeightUnit.feet
        ? value / Consts.feetInMeter
        : value;
  }

  double convertToFeet(double value) {
    return HeightUnit.values[_heightIndex] == HeightUnit.m
        ? value * Consts.feetInMeter
        : value;
  }

  double convertToKg(double value) {
    return WeightUnit.values[_weightIndex] == WeightUnit.lb
        ? value / Consts.lbInKg
        : value;
  }

  double convertToLb(double value) {
    return WeightUnit.values[_weightIndex] == WeightUnit.lb
        ? value * Consts.lbInKg
        : value;
  }

  double calculateBmi(double height, double weight) {
    if (height <= 0 || weight <= 0) {
      return -1;
    }
    return weight / height / height;
  }
}
