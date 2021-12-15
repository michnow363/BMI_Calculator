
import 'package:flutter/material.dart';

class BmiSlider extends StatelessWidget {
  final double _bmiValue;
  final double _min;
  final double _max;
  final Color _color;
  final String _bmiLabel;

  BmiSlider(
      {required double bmiValue,
      double min = 0,
      double max = 60,
      required Color color,
      required String bmiLabel})
      : _bmiValue = bmiValue,
        _min = min,
        _max = max,
        _color = color,
        _bmiLabel = bmiLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Center(
            child: Text(
              _bmiValue == 0 ? '' : 'BMI = ${_bmiValue.toStringAsFixed(2)}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, color: _color),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Center(
            child: Slider(
              min: _min,
              max: _max,
              value: _bmiValue > _max ? _max : _bmiValue,
              onChanged: (newValue) {},
              inactiveColor: _color,
              activeColor: _color,
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Center(
            child: Text(
              _bmiLabel,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, color: _color),
            ),
          ),
        ),
      ],
    );
  }
}
