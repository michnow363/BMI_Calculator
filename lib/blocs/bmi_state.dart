import 'package:equatable/equatable.dart';

abstract class BmiState extends Equatable {
  BmiState(
    this.heightUnit,
    this.weightUnit,
    this.heightValue,
    this.weightValue,
  );

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
}

class ChangeUnitState extends BmiState {
  ChangeUnitState(
    String heightUnit,
    String weightUnit,
    double heightValue,
    double weightValue,
  ) : super(
          heightUnit,
          weightUnit,
          heightValue,
          weightValue,
        );
}
