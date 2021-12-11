import 'package:bmi_calculator/blocs/bmi_state.dart';
import 'package:bmi_calculator/consts.dart';
import 'package:flutter/material.dart';
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
            heightUnit: HeightUnit.values[0].name(),
            weightUnit: WeightUnit.values[0].name(),
            heightValue: 0,
            weightValue: 0,
            bmiValue: 0,
            color: BmiLevel.empty.color(),
            bmiLevelLabel: BmiLevel.empty.label(),
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
          heightUnit: _heightUnit,
          weightUnit: _weightUnit,
          heightValue: _heightValue,
          weightValue: _weightValue,
        ));
      },
    );
    on<ChangeValueEvent>(
      (event, emit) {
        switch (event.valueType) {
          case ValueType.height:
            _heightValue = event.newValue;
            break;
          case ValueType.weight:
            _weightValue = event.newValue;
            break;
        }
        emit(ChangedUnitState(
          heightUnit: _heightUnit,
          weightUnit: _weightUnit,
          heightValue: _heightValue,
          weightValue: _weightValue,
        ));
      },
    );
    on<CalculateBmiEvent>((event, emit) {
      final double heightValueInMetric = _convertToM(_heightValue);
      final double weightValueInMetric = _convertToKg(_weightValue);
      final newBmiValue =
          _calculateBmi(heightValueInMetric, weightValueInMetric);
      if (newBmiValue != _bmiValue && newBmiValue != -1) {
        _bmiValue = newBmiValue;
        emit(CalculatedBmiState(
          bmiValue: _bmiValue,
          color: _getBmiColor(),
          bmiLevelLabel: _getBmiLabel(),
        ));
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

  String _getBmiLabel() {
    final String bmiLevelLabel;
    if(_bmiValue <= 0) {
      bmiLevelLabel = BmiLevel.empty.label();
    } else if (_bmiValue < 16) {
      bmiLevelLabel = BmiLevel.starvation.label();
    } else if (_bmiValue < 17) {
      bmiLevelLabel = BmiLevel.emaciation.label();
    } else if (_bmiValue < 18.5) {
      bmiLevelLabel = BmiLevel.underweight.label();
    } else if (_bmiValue < 25) {
      bmiLevelLabel = BmiLevel.correct.label();
    } else if (_bmiValue < 30) {
      bmiLevelLabel = BmiLevel.overweight.label();
    } else if (_bmiValue < 35) {
      bmiLevelLabel = BmiLevel.obesityI.label();
    } else if (_bmiValue < 40) {
      bmiLevelLabel = BmiLevel.obesityII.label();
    } else {
      bmiLevelLabel = BmiLevel.obesityIII.label();
    }
    return bmiLevelLabel;
  }

  Color _getBmiColor() {
    final Color color;
    if(_bmiValue <= 0) {
      color = BmiLevel.empty.color();
    } else if (_bmiValue < 16) {
      color = BmiLevel.starvation.color();
    } else if (_bmiValue < 17) {
      color = BmiLevel.emaciation.color();
    } else if (_bmiValue < 18.5) {
      color = BmiLevel.underweight.color();
    } else if (_bmiValue < 25) {
      color = BmiLevel.correct.color();
    } else if (_bmiValue < 30) {
      color = BmiLevel.overweight.color();
    } else if (_bmiValue < 35) {
      color = BmiLevel.obesityI.color();
    } else if (_bmiValue < 40) {
      color = BmiLevel.obesityII.color();
    } else {
      color = BmiLevel.obesityIII.color();
    }
    return color;
  }
}
