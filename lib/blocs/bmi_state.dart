import 'package:equatable/equatable.dart';

abstract class BmiState extends Equatable {
  BmiState(): super();
  @override
  List<Object?> get props => [];
}

class ChangeUnitState extends BmiState {
  @override
  List<Object?> get props => [
    this.heightUnit,
    this.weightUnit,
    this.heightValue,
    this.weightValue,
    this.bmiValue,
  ];

  final String heightUnit;
  final String weightUnit;
  final double heightValue;
  final double weightValue;
  final double bmiValue;
  ChangeUnitState(
      this.heightUnit,
      this.weightUnit,
      this.heightValue,
      this.weightValue,
      this.bmiValue,
  ) : super();
}
