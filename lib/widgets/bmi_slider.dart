import 'package:flutter/material.dart';

class BmiSlider extends StatefulWidget {
  final int bmi_value;
  final int min;
  final int max;
  final Color color;

  const BmiSlider(this.bmi_value, this.min, this.max, this.color);

  @override
  State<StatefulWidget> createState() {
    return BmiSliderState(bmi_value, min, max, color);
  }
}

class BmiSliderState extends State<BmiSlider> {
  final int bmi_value;
  final int min;
  final int max;
  final Color color;

  BmiSliderState(this.bmi_value, this.min, this.max, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Center(
            child: Text(
              'BMI: $bmi_value',
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
              value: 16,
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
