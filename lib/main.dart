import 'package:bmi_calculator/blocs/bmi_bloc.dart';
import 'package:bmi_calculator/blocs/bmi_event.dart';
import 'package:bmi_calculator/widgets/bmi_slider.dart';
import 'package:bmi_calculator/widgets/start_button.dart';
import 'package:bmi_calculator/widgets/value_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/bmi_state.dart';
import 'enums.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'BMI Calculator'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _bmiBloc = BmiBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocProvider(
        create: (context) {
          return _bmiBloc;
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 2,
                child: Center(
                  child: ValueRow(
                    'Enter your height',
                    'Change metric',
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
                    ValueType.weight,
                  ),
                ),
              ),
              BlocBuilder<BmiBloc, BmiState>(
                buildWhen: (previousState, state) {
                  return (state as ChangeUnitState).bmiValue !=
                      (previousState as ChangeUnitState).bmiValue;
                },
                builder: (context, state) {
                  return Flexible(
                    flex: 6,
                    child: Center(
                      child: BmiSlider((state as ChangeUnitState).bmiValue, 0,
                          100, Colors.grey),
                    ),
                  );
                },
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.all(50),
                  child: Builder(builder: (context) {
                    return StartButton(
                      () {
                        BlocProvider.of<BmiBloc>(context)
                            .add(CalculateBmiEvent());
                      },
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bmiBloc.close();
    super.dispose();
  }
}
