import 'package:equatable/equatable.dart';

abstract class BmiState extends Equatable {
  BmiState(this.heightUnit, this.weightUnit);
  @override
  List<Object?> get props => [this.heightUnit, this.weightUnit];
  final String heightUnit;
  final String weightUnit;
}

class ChangeUnitState extends BmiState {
  ChangeUnitState(heightUnit, weightUnit) : super(heightUnit, weightUnit);
}