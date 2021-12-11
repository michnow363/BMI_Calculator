import 'package:flutter/material.dart';

class StartButton extends StatelessWidget {
  StartButton(this.onPressed) : super();

  var onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50.0),
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text('Show BMI'),
        ),
      ),
    );
  }
}