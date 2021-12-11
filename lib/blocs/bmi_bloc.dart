import 'package:bmi_calculator/blocs/bmi_state.dart';
import 'package:bmi_calculator/consts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bmi_calculator/extensions.dart';
import '../enums.dart';
import 'bmi_event.dart';

class BmiBloc extends Bloc<BmiEvent, BmiState> {
  int _heightIndex;
  int _weightIndex;
  double _heightValue;
  double _weightValue;
  String _heightUnit;
  String _weightUnit;
  double _bmiValue;

  BmiBloc()
      : _heightIndex = 0,
        _weightIndex = 0,
        _heightValue = 0.0,
        _weightValue = 0.0,
        _heightUnit = HeightUnit.values[0].name(),
        _weightUnit = WeightUnit.values[0].name(),
        _bmiValue = 0,
        super(
          InitialState(
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
            final unitBeforeChange = HeightUnit.values[_heightIndex];
            switch (unitBeforeChange) {
              case HeightUnit.m:
                _heightValue = _convertToFeet(_heightValue);
                break;
              case HeightUnit.feet:
                _heightValue = _convertToM(_heightValue);
                break;
            }
            _heightIndex = _nextHeightIndex(HeightUnit.values.length);
            final unit = HeightUnit.values[_heightIndex];
            _heightUnit = unit.name();
            break;
          case ValueType.weight:
            final unitBeforeChange = WeightUnit.values[_weightIndex];
            switch (unitBeforeChange) {
              case WeightUnit.kg:
                _weightValue = _convertToLb(_weightValue);
                break;
              case WeightUnit.lb:
                _weightValue = _convertToKg(_weightValue);
                break;
            }
            _weightIndex = _nextWeightIndex(WeightUnit.values.length);
            final unit = WeightUnit.values[_weightIndex];
            _weightUnit = unit.name();
            break;
        }
        emit(ChangedUnitState(
          _heightUnit,
          _weightUnit,
          _heightValue,
          _weightValue,
        ));
      },
    );
    on<ChangeValueEvent>(
      (event, emit) {
        switch (event.valueType) {
          case ValueType.height:
            _heightValue = event.newValue;
            emit(ChangedUnitState(
                _heightUnit, _weightUnit, _heightValue, _weightValue));
            break;
          case ValueType.weight:
            _weightValue = event.newValue;
            emit(ChangedUnitState(
                _heightUnit, _weightUnit, _heightValue, _weightValue));
            break;
        }
      },
    );
    on<CalculateBmiEvent>((event, emit) {
      final double heightValueInMetric = _convertToM(_heightValue);
      final double weightValueInMetric = _convertToKg(_weightValue);
      final newBmiValue = _calculateBmi(heightValueInMetric, weightValueInMetric);
      if (newBmiValue != _bmiValue && newBmiValue != -1) {
        _bmiValue = newBmiValue;
        emit(CalculatedBmiState(_bmiValue));
      }
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

  double _convertToM(double value) {
    return HeightUnit.values[_heightIndex] == HeightUnit.feet
        ? value / Consts.feetInMeter
        : value;
  }

  double _convertToFeet(double value) {
    return HeightUnit.values[_heightIndex] == HeightUnit.m
        ? value * Consts.feetInMeter
        : value;
  }

  double _convertToKg(double value) {
    return WeightUnit.values[_weightIndex] == WeightUnit.lb
        ? value / Consts.lbInKg
        : value;
  }

  double _convertToLb(double value) {
    return WeightUnit.values[_weightIndex] == WeightUnit.kg
        ? value * Consts.lbInKg
        : value;
  }

  double _calculateBmi(double height, double weight) {
    if (height <= 0 || weight <= 0) {
      return -1;
    }
    return weight / height / height;
  }
}
