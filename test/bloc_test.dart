
import 'package:bloc_test/bloc_test.dart';
import 'package:bmi_calculator/blocs/bmi_bloc.dart';
import 'package:bmi_calculator/blocs/bmi_event.dart';
import 'package:bmi_calculator/blocs/bmi_state.dart';
import 'package:bmi_calculator/consts.dart';
import 'package:bmi_calculator/enums.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('BmiBloc', () {
    blocTest(
      'emits [] when nothing is added',
      build: () => BmiBloc(),
      expect: () => [],
    );

    blocTest(
      'ChangeValueEvent tests',
      build: () => BmiBloc(),
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
      build: () => BmiBloc(),
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
          weightValue: 67.59 * Consts.lbInKg,
        ),
        ChangedValueState(
          heightUnit: HeightUnit.m.name,
          weightUnit: WeightUnit.funt.name,
          heightValue: 1.69,
          weightValue: 67.59 / Consts.kgInFunt,
        ),
        ChangedValueState(
          heightUnit: HeightUnit.m.name,
          weightUnit: WeightUnit.kg.name,
          heightValue: 1.69,
          weightValue: 67.59,
        ),
        ChangedValueState(
          heightUnit: HeightUnit.foot.name,
          weightUnit: WeightUnit.kg.name,
          heightValue: 1.69 * Consts.feetInMeter,
          weightValue: 67.59,
        ),
        ChangedValueState(
          heightUnit: HeightUnit.lokiec.name,
          weightUnit: WeightUnit.kg.name,
          heightValue: 1.69 / Consts.metersInLokiec,
          weightValue: 67.59,
        ),
        ChangedValueState(
          heightUnit: HeightUnit.m.name,
          weightUnit: WeightUnit.kg.name,
          heightValue: 1.69,
          weightValue: 67.59,
        ),
      ],
    );

    blocTest(
      'CalculatedBmiEvent tested',
      build: () => BmiBloc(),
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
          bmiValue: 17.5,
          bmiLevel: BmiLevel.underweight,
        ),ChangedValueState(
          heightUnit: HeightUnit.m.name,
          weightUnit: WeightUnit.lb.name,
          heightValue: 2,
          weightValue: 70 * Consts.lbInKg,
        ),
        ChangedValueState(
          heightUnit: HeightUnit.foot.name,
          weightUnit: WeightUnit.lb.name,
          heightValue: 2 * Consts.feetInMeter,
          weightValue: 70 * Consts.lbInKg,
        ),
        // CalculatedBmiState not emitted, because value is the same
      ],
    );
  });
}
