import 'package:flutter_bloc/flutter_bloc.dart';

import '../enums.dart';
import '../extensions.dart';
import 'bmi_event.dart';
import 'bmi_state.dart';
import 'bmi_calculator.dart';

class BmiBloc extends Bloc<BmiEvent, BmiState> {
  HeightUnit _heightUnit;
  WeightUnit _weightUnit;
  double _heightValue;
  double _weightValue;
  double _bmiValue;
  List<BmiCalculator> _bmiCalculators;

  BmiBloc()
      : _heightUnit = HeightUnit.values[0],
        _weightUnit = WeightUnit.values[0],
        _heightValue = 0.0,
        _weightValue = 0.0,
        _bmiValue = 0,
        _bmiCalculators = [MetricCalculator(), ImperialCalculator(), OldPolishCalculator()],
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
        final unitBeforeChange = HeightUnit.values[_heightUnit.index];
        final heightIndex = _nextHeightIndex();
        _heightUnit = HeightUnit.values[heightIndex];
        _heightValue = _bmiCalculators[_heightUnit.unitSystem().index]
            .convertHeight(_heightValue, unitBeforeChange);
        break;
      case ValueType.weight:
        final unitBeforeChange = WeightUnit.values[_weightUnit.index];
        final weightIndex = _nextWeightIndex();
        _weightUnit = WeightUnit.values[weightIndex];
        _weightValue = _bmiCalculators[_weightUnit.unitSystem().index]
            .convertWeight(_weightValue, unitBeforeChange);
        break;
    }
    emit(ChangedValueState(
      heightUnit: _heightUnit.name,
      weightUnit: _weightUnit.name,
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
      heightUnit: _heightUnit.name,
      weightUnit: _weightUnit.name,
      heightValue: _heightValue,
      weightValue: _weightValue,
    ));
  }

  void calculateAndEmitBmi(event, emit) async {
    final newBmiValue = BmiCalculator.calculateBmi(
      _heightValue,
      HeightUnit.values[_heightUnit.index],
      _weightValue,
      WeightUnit.values[_weightUnit.index],
    );
    if (newBmiValue != _bmiValue && newBmiValue != -1) {
      _bmiValue = newBmiValue;
      emit(CalculatedBmiState(
        bmiValue: _bmiValue,
        bmiLevel: BmiCalculator.getBmiLevel(_bmiValue),
      ));
    }
  }

  int _nextHeightIndex() {
    return (_heightUnit.index + 1) % HeightUnit.values.length;
  }

  int _nextWeightIndex() {
    return (_weightUnit.index + 1) % WeightUnit.values.length;
  }
}
