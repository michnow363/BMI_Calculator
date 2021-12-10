import 'package:bmi_calculator/enums.dart';
import 'package:equatable/equatable.dart';

abstract class BmiEvent extends Equatable {
  const BmiEvent();
  @override
  List<Object?> get props => [];
}

class ChangeUnitEvent extends BmiEvent {
  final ValueType valueType;
  ChangeUnitEvent(this.valueType);
}

class ChangeValueEvent extends BmiEvent {
  final ValueType valueType;
  final double newValue;
  ChangeValueEvent(this.valueType, this.newValue);
}