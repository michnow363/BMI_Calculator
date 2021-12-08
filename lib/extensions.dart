import 'blocs/value_rows_bloc.dart';

extension HeightUnitExtension on HeightUnit {
  String name() {
    return this.toString().split('.').last;
  }
}

extension WeightUnitExtension on WeightUnit {
  String name() {
    return this.toString().split('.').last;
  }
}