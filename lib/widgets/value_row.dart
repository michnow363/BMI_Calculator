import 'package:flutter/material.dart';

class ValueRow extends StatefulWidget {
  final String _text_box_title;
  final String _button_tooltip;
  final String _unit;

  ValueRow(this._text_box_title, this._button_tooltip, this._unit);

  @override
  State<StatefulWidget> createState() {
    return ValueRowState(_text_box_title, _button_tooltip, _unit);
  }
}

class ValueRowState extends State<ValueRow> {
  final String _text_box_title;
  final String _button_tooltip;
  final String _unit;

  ValueRowState(this._text_box_title, this._button_tooltip, this._unit);

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
                  child: Text(
                    _unit,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
              ),
            ),
            Flexible(
                flex: 2,
                child: FloatingActionButton(
                  onPressed: () => {},
                  tooltip: _button_tooltip,
                  child: Icon(Icons.change_circle_outlined),
                )),
          ]),
    );
  }
}
