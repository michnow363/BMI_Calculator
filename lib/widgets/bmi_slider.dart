import 'package:flutter/material.dart';

class BmiSlider extends StatelessWidget {
  final double bmiValue;
  final double min;
  final double max;
  final Color color;

  BmiSlider(this.bmiValue, this.min, this.max, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Center(
            child: Text(
              'BMI: ${bmiValue.toStringAsFixed(2)}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, color: color),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Center(
            child: Slider(
              min: 0,
              max: 100,
              value: bmiValue,
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
              style: TextStyle(fontSize: 30, color: color),
            ),
          ),
        ),
      ],
    );
  }
}
