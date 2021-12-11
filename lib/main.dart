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
  double bmiValue = 0;

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
                    textBoxTitle: 'Enter your height',
                    buttonTooltip: 'Change metric',
                    valueType: ValueType.height,
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Center(
                  child: ValueRow(
                    textBoxTitle: 'Enter your weight',
                    buttonTooltip: 'Change metric',
                    valueType: ValueType.weight,
                  ),
                ),
              ),
              BlocBuilder<BmiBloc, BmiState>(
                buildWhen: (previousState, state) {
                  final needRebuilding =
                      widgetNeedRebuilding(previousState, state);
                  if (needRebuilding) {
                    getBmiValue(state);
                  }
                  return needRebuilding;
                },
                builder: (context, state) {
                  return Flexible(
                    flex: 6,
                    child: Center(
                      child: BmiSlider(
                        bmiValue: bmiValue,
                        min: 0,
                        max: 100,
                        color: Colors.grey,
                      ),
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
                      onPressed: () {
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

  bool widgetNeedRebuilding(BmiState previousState, BmiState state) {
    if (state is InitialState || state is CalculatedBmiState) {
      return true;
    } else {
      return false;
    }
  }

  void getBmiValue(BmiState state) {
    if (state is InitialState) {
      bmiValue = state.bmiValue;
    }
    if (state is CalculatedBmiState) {
      bmiValue = state.bmiValue;
    }
  }

  @override
  void dispose() {
    _bmiBloc.close();
    super.dispose();
  }
}
