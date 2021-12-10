import 'package:bmi_calculator/blocs/bmi_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bmi_calculator/extensions.dart';
import '../enums.dart';
import 'bmi_event.dart';

class BmiBloc extends Bloc<BmiEvent, BmiState> {
  int _heightIndex;
  int _weightIndex;
  String heightUnit;
  String weightUnit;

  BmiBloc()
      : _heightIndex = 0,
        _weightIndex = 0,
        heightUnit = HeightUnit.values[0].name(),
        weightUnit = WeightUnit.values[0].name(),
        super(
          ChangeUnitState(
              HeightUnit.values[0].name(), WeightUnit.values[0].name()),
        )
  {
    on<ChangeUnitEvent>(
      (event, emit) {
        switch (event.valueType) {
          case ValueType.height:
            _heightIndex = _nextHeightIndex(HeightUnit.values.length);
            heightUnit = HeightUnit.values[_heightIndex].name();
            emit(ChangeUnitState(heightUnit, weightUnit));
            break;
          case ValueType.weight:
            _weightIndex = _nextWeightIndex(WeightUnit.values.length);
            weightUnit = WeightUnit.values[_weightIndex].name();
            emit(ChangeUnitState(heightUnit, weightUnit));
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
}
