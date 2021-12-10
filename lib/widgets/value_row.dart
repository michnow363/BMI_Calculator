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

  ValueRowState(
    this._textBoxTitle,
    this._buttonTooltip,
    this._valueType,
  );

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
                onChanged: (value) {
                  if (value.isNotEmpty) {}
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: _textBoxTitle,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Center(
              child: BlocBuilder<BmiBloc, BmiState>(
                buildWhen: (previousState, state) {
                  return (previousState.weightUnit != state.weightUnit) ||
                      (previousState.heightUnit != state.heightUnit);
                },
                builder: (context, state) {
                  return Text(
                    _valueType == ValueType.height
                        ? state.heightUnit
                        : state.weightUnit,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  );
                },
              ),
            ),
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
}
