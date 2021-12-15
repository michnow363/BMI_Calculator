import 'package:flutter_bloc/flutter_bloc.dart';

import '../enums.dart';
import '../extensions.dart';
import 'bmi_event.dart';
import 'bmi_state.dart';
import 'bmi_calculator.dart';

class BmiBloc extends Bloc<BmiEvent, BmiState> {
  int _heightIndex;
  int _weightIndex;
  double _heightValue;
  double _weightValue;
  String _heightUnit;
  String _weightUnit;
  double _bmiValue;
  List<BmiCalculator> _bmiCalculators;

  BmiBloc()
      : _heightIndex = 0,
        _weightIndex = 0,
        _heightValue = 0.0,
        _weightValue = 0.0,
        _heightUnit = HeightUnit.values[0].name,
        _weightUnit = WeightUnit.values[0].name,
        _bmiValue = 0,
        _bmiCalculators = [MetricCalculator(), ImperialCalculator()],
        super(
          InitialState(
            heightUnit: HeightUnit.values[0].name,
            weightUnit: WeightUnit.values[0].name,
            heightValue: 0,
            weightValue: 0,
            bmiValue: 0,
            bmiLevel: BmiLevel.empty,
          ),
        ) {
    on<ChangeUnitEvent>(changeAndEmitUnit);
    on<ChangeValueEvent>(changeAndEmitValue);
    on<CalculateBmiEvent>(calculateAndEmitBmi);
  }

  void changeAndEmitUnit(event, emit) {
    switch (event.valueType) {
      case ValueType.height:
        final unitBeforeChange = HeightUnit.values[_heightIndex];
        _heightIndex = _nextHeightIndex(HeightUnit.values.length);
        final unit = HeightUnit.values[_heightIndex];
        _heightValue = _bmiCalculators[unit.unitSystem().index]
            .convertHeight(_heightValue, unitBeforeChange);
        _heightUnit = unit.name;
        break;
      case ValueType.weight:
        final unitBeforeChange = WeightUnit.values[_weightIndex];
        _weightIndex = _nextWeightIndex(WeightUnit.values.length);
        final unit = WeightUnit.values[_weightIndex];
        _weightValue = _bmiCalculators[unit.unitSystem().index]
            .convertWeight(_weightValue, unitBeforeChange);
        _weightUnit = unit.name;
        break;
    }
    emit(ChangedValueState(
      heightUnit: _heightUnit,
      weightUnit: _weightUnit,
      heightValue: _heightValue,
      weightValue: _weightValue,
    ));
  }

  void changeAndEmitValue(event, emit) async {
    switch (event.valueType) {
      case ValueType.height:
        _heightValue = event.newValue;
        break;
      case ValueType.weight:
        _weightValue = event.newValue;
        break;
    }
    emit(ChangedValueState(
      heightUnit: _heightUnit,
      weightUnit: _weightUnit,
      heightValue: _heightValue,
      weightValue: _weightValue,
    ));
  }

  void calculateAndEmitBmi(event, emit) async {
    final newBmiValue = BmiCalculator.calculateBmi(
      _heightValue,
      HeightUnit.values[_heightIndex],
      _weightValue,
      WeightUnit.values[_weightIndex],
    );
    if (newBmiValue != _bmiValue && newBmiValue != -1) {
      _bmiValue = newBmiValue;
      emit(CalculatedBmiState(
        bmiValue: _bmiValue,
        bmiLevel: _getBmiLevel(),
      ));
    }
  }

  int _nextHeightIndex(int numberOfValues) {
    ++_heightIndex;
    return _heightIndex % numberOfValues;
  }

  int _nextWeightIndex(int numberOfValues) {
    ++_weightIndex;
    return _weightIndex % numberOfValues;
  }

  BmiLevel _getBmiLevel() {
    final BmiLevel bmiLevel;
    if (_bmiValue <= 0) {
      bmiLevel = BmiLevel.empty;
    } else if (_bmiValue < 16) {
      bmiLevel = BmiLevel.starvation;
    } else if (_bmiValue < 17) {
      bmiLevel = BmiLevel.emaciation;
    } else if (_bmiValue < 18.5) {
      bmiLevel = BmiLevel.underweight;
    } else if (_bmiValue < 25) {
      bmiLevel = BmiLevel.correct;
    } else if (_bmiValue < 30) {
      bmiLevel = BmiLevel.overweight;
    } else if (_bmiValue < 35) {
      bmiLevel = BmiLevel.obesityI;
    } else if (_bmiValue < 40) {
      bmiLevel = BmiLevel.obesityII;
    } else {
      bmiLevel = BmiLevel.obesityIII;
    }
    return bmiLevel;
  }
}
