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
                heightValue = convertFromFeetToM(heightValue);
                break;
              case HeightUnit.feet:
                heightValue = convertFromMToFeet(heightValue);
                break;
            }
            emit(ChangeUnitState(
                heightUnit, weightUnit, heightValue, weightValue));
            break;
          case ValueType.weight:
            _weightIndex = _nextWeightIndex(WeightUnit.values.length);
            final unit = WeightUnit.values[_weightIndex];
            weightUnit = unit.name();
            switch (unit) {
              case WeightUnit.kg:
                weightValue = convertFromLbToKg(weightValue);
                break;
              case WeightUnit.lb:
                weightValue = convertFromKgToLb(weightValue);
                break;
            }
            emit(ChangeUnitState(
                heightUnit, weightUnit, heightValue, weightValue));
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
                heightUnit, weightUnit, heightValue, weightValue));
            break;
          case ValueType.weight:
            weightValue = event.newValue;
            emit(ChangeUnitState(
                heightUnit, weightUnit, heightValue, weightValue));
            break;
        }
      },
    );
  }

  int _nextHeightIndex(int numberOfValues) {
    ++_heightIndex;
    return _heightIndex % numberOfValues;
  }

  int _nextWeightIndex(int numberOfValues) {
    ++_weightIndex;
    return _weightIndex % numberOfValues;
  }

  double convertFromFeetToM(double valueFeet) {
    return valueFeet / Consts.feetInMeter;
  }

  double convertFromLbToKg(double valueLb) {
    return valueLb / Consts.lbInKg;
  }

  double convertFromMToFeet(double valueM) {
    return valueM * Consts.feetInMeter;
  }

  double convertFromKgToLb(double valueKg) {
    return valueKg * Consts.lbInKg;
  }
}
