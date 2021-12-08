import 'dart:async';
import 'package:bmi_calculator/extensions.dart';

class ValueRowsBloc {
  int _heightValueIndex = 0;
  int _weightValueIndex = 0;

  final _heightStateStreamController = StreamController<String>();
  StreamSink<String> get heightValueRowSink => _heightStateStreamController.sink;
  Stream<String> get heightValueRowStream => _heightStateStreamController.stream;
  
  final _weightStateStreamController = StreamController<String>();
  StreamSink<String> get weightValueRowSink => _weightStateStreamController.sink;
  Stream<String> get weightValueRowStream => _weightStateStreamController.stream;

  final _eventStreamController = StreamController<ValueType>();
  StreamSink<ValueType> get eventSink => _eventStreamController.sink;
  Stream<ValueType> get eventStream => _eventStreamController.stream;

  ValueRowsBloc() {
    eventStream.listen((event) {
      switch(event){
        case ValueType.height:
          _heightValueIndex = nextIndex(_heightValueIndex, HeightUnit.values.length);
          heightValueRowSink.add(HeightUnit.values[_heightValueIndex].name());
          break;
        case ValueType.weight:
          _weightValueIndex = nextIndex(_weightValueIndex, WeightUnit.values.length);
          weightValueRowSink.add(WeightUnit.values[_weightValueIndex].name());
          break;
      }
    });
  }

  int nextIndex(int index, int numberOfValues) {
    return (index + 1) % numberOfValues;
  }
}

enum ValueType {
  height,
  weight,
}

enum HeightUnit {
  m,
  feet
}

enum WeightUnit {
  kg,
  lb,
}

