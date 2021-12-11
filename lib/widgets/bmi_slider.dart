import 'package:flutter/material.dart';

class BmiSlider extends StatelessWidget {
  final double _bmiValue;
  final double _min;
  final double _max;
  final Color _color;

  BmiSlider({required double bmiValue, double min = 0, double max = 100, required Color color})
      : _bmiValue = bmiValue,
        _min = min,
        _max = max,
        _color = color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Center(
            child: Text(
              'BMI: ${_bmiValue.toStringAsFixed(2)}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, color: _color),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Center(
            child: Slider(
              min: _min,
              max: _max,
              value: _bmiValue,
              onChanged: (newValue) {},
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Center(
            child: Text(
              'Underweight',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, color: _color),
            ),
          ),
        ),
      ],
    );
  }
}
