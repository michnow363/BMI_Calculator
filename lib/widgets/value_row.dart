import 'package:bmi_calculator/blocs/bmi_bloc.dart';
import 'package:bmi_calculator/blocs/bmi_event.dart';
import 'package:bmi_calculator/blocs/bmi_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../enums.dart';

class ValueRow extends StatefulWidget {
  final ValueType _valueType;
  final String _textBoxTitle;
  final String _buttonTooltip;

  ValueRow(
    this._textBoxTitle,
    this._buttonTooltip,
    this._valueType,
  );

  @override
  State<StatefulWidget> createState() {
    return ValueRowState(
      _textBoxTitle,
      _buttonTooltip,
      _valueType,
    );
  }
}

class ValueRowState extends State<ValueRow> {
  final ValueType _valueType;
  final String _textBoxTitle;
  final String _buttonTooltip;
  bool _valueEmpty;

  ValueRowState(
    this._textBoxTitle,
    this._buttonTooltip,
    this._valueType,
  ): _valueEmpty = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          BlocBuilder<BmiBloc, BmiState>(
            buildWhen: (previousState, state) {
              return widgetNeedRebuild(previousState, state);
            },
            builder: (context, state) {
              return Flexible(
                flex: 6,
                child: Row(
                  children: [
                    Flexible(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: TextFormField(
                          key: UniqueKey(),
                          initialValue: '${_valueType == ValueType.height
                              ? state.heightValue.toStringAsFixed(2)
                              : state.weightValue.toStringAsFixed(2)
                            }',
                          onFieldSubmitted: (value) {
                            if (value.isNotEmpty) {
                              final valueDb = double.parse(value);
                              _valueEmpty = valueDb > 0 ? false : true;
                              BlocProvider.of<BmiBloc>(context)
                                .add(ChangeValueEvent(_valueType, valueDb));
                              value = valueDb.toStringAsFixed(2);
                            } else {
                              _valueEmpty = true;
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: _valueEmpty ? _textBoxTitle : '',
                            labelStyle: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Center(
                        child: Text(
                          _valueType == ValueType.height
                              ? state.heightUnit
                              : state.weightUnit,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Flexible(
            flex: 2,
            child: FloatingActionButton(
              onPressed: () {
                BlocProvider.of<BmiBloc>(context)
                    .add(ChangeUnitEvent(_valueType));
              },
              tooltip: _buttonTooltip,
              child: Icon(Icons.change_circle_outlined),
            ),
          ),
        ],
      ),
    );
  }

  bool widgetNeedRebuild(BmiState previousState, BmiState state) {
    bool rowValueChanged;
    bool changedUnitWithValueZero;
    rowValueChanged = _valueType == ValueType.height && (previousState.heightValue != state.heightValue)
        || _valueType == ValueType.weight && (previousState.weightValue != state.weightValue);
    changedUnitWithValueZero = state.heightValue == 0 || state.weightValue == 0;
    return rowValueChanged || changedUnitWithValueZero;
  }
}
