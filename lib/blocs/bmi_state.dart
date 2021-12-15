
import 'package:bmi_calculator/enums.dart';
import 'package:equatable/equatable.dart';

abstract class BmiState extends Equatable {
  BmiState() : super();

  @override
  List<Object?> get props => [];
}

class InitialState extends BmiState {
  @override
  List<Object?> get props => [
        this.heightUnit,
        this.weightUnit,
        this.heightValue,
        this.weightValue,
        this.bmiValue,
        this.bmiLevel,
      ];

  final String heightUnit;
  final String weightUnit;
  final double heightValue;
  final double weightValue;
  final double bmiValue;
  final BmiLevel bmiLevel;

  InitialState(
      {required this.heightUnit,
      required this.weightUnit,
      required this.heightValue,
      required this.weightValue,
      required this.bmiValue,
      required this.bmiLevel,})
      : super();
}

class ChangedValueState extends BmiState {
  @override
  List<Object?> get props => [
        this.heightUnit,
        this.weightUnit,
        this.heightValue,
        this.weightValue,
      ];

  final String heightUnit;
  final String weightUnit;
  final double heightValue;
  final double weightValue;

  ChangedValueState({
    required this.heightUnit,
    required this.weightUnit,
    required this.heightValue,
    required this.weightValue,
  }) : super();
}

class CalculatedBmiState extends BmiState {
  @override
  List<Object?> get props => [
        this.bmiValue,
        this.bmiLevel,
      ];

  final double bmiValue;
  final bmiLevel;

  CalculatedBmiState({
    required this.bmiValue,
    required this.bmiLevel,
  }) : super();
}
