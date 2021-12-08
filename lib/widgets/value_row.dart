import 'package:bmi_calculator/blocs/value_rows_bloc.dart';
import 'package:flutter/material.dart';

class ValueRow extends StatefulWidget {
  final ValueType _valueType;
  final String _text_box_title;
  final String _button_tooltip;
  final String _starting_unit;

  ValueRow(
    this._text_box_title,
    this._button_tooltip,
    this._starting_unit,
    this._valueType,
  );

  @override
  State<StatefulWidget> createState() {
    return ValueRowState(
      _text_box_title,
      _button_tooltip,
      _starting_unit,
      _valueType,
    );
  }
}

class ValueRowState extends State<ValueRow> {
  final ValueType _valueType;
  final String _text_box_title;
  final String _button_tooltip;
  final String _starting_unit;
  final valueRowsBloc = ValueRowsBloc();
  Stream<String> stream;

  ValueRowState(
    this._text_box_title,
    this._button_tooltip,
    this._starting_unit,
    this._valueType,
  ) {
    switch (_valueType) {
      case ValueType.height:
        stream = valueRowsBloc.heightValueRowStream;
        break;
      case ValueType.weight:
        stream = valueRowsBloc.weightValueRowStream;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: _text_box_title,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Center(
                child: StreamBuilder(
                    stream: stream,
                    builder: (context, snapshot) {
                      return Text(
                        '${snapshot.data ?? _starting_unit}',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      );
                    }),
              ),
            ),
            Flexible(
                flex: 2,
                child: FloatingActionButton(
                  onPressed: () {
                    valueRowsBloc.eventSink.add(_valueType);
                  },
                  tooltip: _button_tooltip,
                  child: Icon(Icons.change_circle_outlined),
                )),
          ]),
    );
  }
}

