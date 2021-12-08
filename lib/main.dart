import 'package:bmi_calculator/widgets/bmi_slider.dart';
import 'package:bmi_calculator/widgets/start_button.dart';
import 'package:bmi_calculator/widgets/value_row.dart';
import 'package:flutter/material.dart';
import 'blocs/value_rows_bloc.dart';
import 'package:bmi_calculator/extensions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'BMI Calculator'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 2,
              child: Center(
                child: ValueRow(
                  'Enter your height',
                  'Change metric',
                  '${HeightUnit.values[0].name()}',
                  ValueType.height,
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Center(
                child: ValueRow(
                  'Enter your weight',
                  'Change metric',
                  '${WeightUnit.values[0].name()}',
                  ValueType.weight,
                ),
              ),
            ),
            Flexible(
              flex: 6,
              child: Center(
                child: BmiSlider(0, 0, 100, Colors.grey),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.all(50),
                child: StartButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
