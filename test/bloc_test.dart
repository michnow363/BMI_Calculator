import 'package:bloc_test/bloc_test.dart';
import 'package:bmi_calculator/blocs/bmi_bloc.dart';
import 'package:bmi_calculator/blocs/bmi_converter.dart';
import 'package:bmi_calculator/blocs/bmi_event.dart';
import 'package:bmi_calculator/blocs/bmi_state.dart';
import 'package:bmi_calculator/enums.dart';
import 'package:flutter_test/flutter_test.dart';

import 'bmi_mocks.dart';

void main() {
  group('BmiBloc', () {
    blocTest(
      'emits [] when nothing is added',
      build: () => BmiBloc(
        MockBmiCalculator(),
        <BmiConverter>[
          MockMetricConverter(),
          MockImperialConverter(),
          MockOldPolishConverter(),
        ],
      ),
      expect: () => [],
    );

    blocTest(
      'ChangeValueEvent tests',
      build: () => BmiBloc(
        MockBmiCalculator(),
        <BmiConverter>[
          MockMetricConverter(),
          MockImperialConverter(),
          MockOldPolishConverter(),
        ],
      ),
      act: (bloc) => (bloc as BmiBloc)
        ..add(ChangeValueEvent(ValueType.height, 1.69))
        ..add(ChangeValueEvent(ValueType.weight, 65.5)),
      expect: () => [
        ChangedValueState(
          heightUnit: HeightUnit.m.name,
          weightUnit: WeightUnit.kg.name,
          heightValue: 1.69,
          weightValue: 0,
        ),
        ChangedValueState(
          heightUnit: HeightUnit.m.name,
          weightUnit: WeightUnit.kg.name,
          heightValue: 1.69,
          weightValue: 65.5,
        )
      ],
    );

    blocTest(
      'ChangeUnitEvent tests',
      build: () => BmiBloc(
        MockBmiCalculator(),
        <BmiConverter>[
          MockMetricConverter(),
          MockImperialConverter(),
          MockOldPolishConverter(),
        ],
      ),
      act: (bloc) => (bloc as BmiBloc)
        ..add(ChangeValueEvent(ValueType.height, 1.69))
        ..add(ChangeValueEvent(ValueType.weight, 67.59))
        ..add(ChangeUnitEvent(ValueType.weight))
        ..add(ChangeUnitEvent(ValueType.weight))
        ..add(ChangeUnitEvent(ValueType.weight))
        ..add(ChangeUnitEvent(ValueType.height))
        ..add(ChangeUnitEvent(ValueType.height))
        ..add(ChangeUnitEvent(ValueType.height)),
      skip: 2,
      expect: () => [
        ChangedValueState(
          heightUnit: HeightUnit.m.name,
          weightUnit: WeightUnit.lb.name,
          heightValue: 1.69,
          weightValue: 2,
        ),
        ChangedValueState(
          heightUnit: HeightUnit.m.name,
          weightUnit: WeightUnit.funt.name,
          heightValue: 1.69,
          weightValue: 3,
        ),
        ChangedValueState(
          heightUnit: HeightUnit.m.name,
          weightUnit: WeightUnit.kg.name,
          heightValue: 1.69,
          weightValue: 1,
        ),
        ChangedValueState(
          heightUnit: HeightUnit.foot.name,
          weightUnit: WeightUnit.kg.name,
          heightValue: 2,
          weightValue: 1,
        ),
        ChangedValueState(
          heightUnit: HeightUnit.lokiec.name,
          weightUnit: WeightUnit.kg.name,
          heightValue: 3,
          weightValue: 1,
        ),
        ChangedValueState(
          heightUnit: HeightUnit.m.name,
          weightUnit: WeightUnit.kg.name,
          heightValue: 1,
          weightValue: 1,
        ),
      ],
    );

    blocTest(
      'CalculatedBmiEvent tested',
      build: () => BmiBloc(
        MockBmiCalculator(),
        <BmiConverter>[
          MockMetricConverter(),
          MockImperialConverter(),
          MockOldPolishConverter(),
        ],
      ),
      act: (bloc) => (bloc as BmiBloc)
        ..add(ChangeValueEvent(ValueType.height, 2))
        ..add(ChangeValueEvent(ValueType.weight, 70))
        ..add(CalculateBmiEvent())
        ..add(ChangeUnitEvent(ValueType.weight))
        ..add(ChangeUnitEvent(ValueType.height))
        ..add(CalculateBmiEvent()),
      skip: 2,
      expect: () => [
        CalculatedBmiState(
          bmiValue: 20,
          bmiLevel: BmiLevel.correct,
        ),
        ChangedValueState(
          heightUnit: HeightUnit.m.name,
          weightUnit: WeightUnit.lb.name,
          heightValue: 2,
          weightValue: 2,
        ),
        ChangedValueState(
          heightUnit: HeightUnit.foot.name,
          weightUnit: WeightUnit.lb.name,
          heightValue: 2,
          weightValue: 2,
        ),
        // CalculatedBmiState not emitted, because value is the same
      ],
    );
  });
}
