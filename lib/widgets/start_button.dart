import 'package:flutter/material.dart';

class StartButton extends StatelessWidget {
  StartButton({required Function() onPressed})
      : _onPressed = onPressed,
        super();

  final Function() _onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50.0),
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: ElevatedButton(
          onPressed: _onPressed,
          child: Text(
            'Show BMI',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
