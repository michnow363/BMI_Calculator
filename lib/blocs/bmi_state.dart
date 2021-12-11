import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
        this.color,
        this.bmiLevelLabel
      ];

  final String heightUnit;
  final String weightUnit;
  final double heightValue;
  final double weightValue;
  final double bmiValue;
  final Color color;
  final String bmiLevelLabel;

  InitialState(
      {required this.heightUnit,
      required this.weightUnit,
      required this.heightValue,
      required this.weightValue,
      required this.bmiValue,
      required this.color,
      required this.bmiLevelLabel})
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
        this.color,
        this.bmiLevelLabel,
      ];

  final double bmiValue;
  final Color color;
  final String bmiLevelLabel;

  CalculatedBmiState({
    required this.bmiValue,
    required this.color,
    required this.bmiLevelLabel,
  }) : super();
}
