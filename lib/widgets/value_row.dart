
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/bmi_bloc.dart';
import '../blocs/bmi_event.dart';
import '../blocs/bmi_state.dart';
import '../enums.dart';

class ValueRow extends StatefulWidget {
  final String _textBoxTitle;
  final String _buttonTooltip;
  final ValueType _valueType;

  ValueRow({
    required String textBoxTitle,
    required String buttonTooltip,
    required ValueType valueType,
  })  : _textBoxTitle = textBoxTitle,
        _buttonTooltip = buttonTooltip,
        _valueType = valueType;

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
  final TextEditingController textController;

  ValueRowState(
    this._textBoxTitle,
    this._buttonTooltip,
    this._valueType,
  )   :
    this.textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textController.addListener(textValueChanged);
  }

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
              final needRebuilding = widgetNeedRebuilding(previousState, state);
              getValue(state);
              return needRebuilding;
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
                          controller: textController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: _textBoxTitle,
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Center(
                        child: Text(
                          getUnit(state),
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

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  bool widgetNeedRebuilding(BmiState previousState, BmiState state) {
    if (state is ChangedValueState) {
      return true;
    } else {
      return false;
    }
  }
  String getUnit(BmiState state) {
    String unit = '';
    if (state is InitialState) {
      unit = _valueType == ValueType.height
          ? state.heightUnit
          : state.weightUnit;
    }
    if (state is ChangedValueState) {
      unit = _valueType == ValueType.height
          ? state.heightUnit
          : state.weightUnit;
    }
    return unit;
  }
  void getValue(BmiState state) {
    double value = 0;
    if (state is InitialState) {
      value = _valueType == ValueType.height
          ? state.heightValue
          : state.weightValue;
      textController.text = value.toString();
    }
    if (state is ChangedValueState) {
      value = _valueType == ValueType.height
          ? state.heightValue
          : state.weightValue;
      textController.text = value.toString();
    }
  }
  void textValueChanged() {
    var text = textController.text;
    if (text.isNotEmpty) {
      final valueDb = double.parse(text);
      BlocProvider.of<BmiBloc>(context).add(ChangeValueEvent(_valueType, valueDb));
    }
  }
}
