
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/bmi_bloc.dart';
import 'blocs/bmi_event.dart';
import 'blocs/bmi_state.dart';
import 'enums.dart';
import 'extensions.dart';
import 'widgets/bmi_slider.dart';
import 'widgets/start_button.dart';
import 'widgets/value_row.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
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
                  return needRebuilding;
                },
                builder: (context, state) {
                  return Flexible(
                    flex: 6,
                    child: Center(
                      child: BmiSlider(
                        bmiValue: getBmiValue(state),
                        min: 0,
                        max: 60,
                        color: getBmiLevel(state).color(),
                        bmiLabel: getBmiLevel(state).label(),
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
    if (state is CalculatedBmiState) {
      return true;
    } else {
      return false;
    }
  }

  double getBmiValue(BmiState state) {
    double bmiValue = 0;
    if (state is InitialState) {
      bmiValue = state.bmiValue;
    }
    if (state is CalculatedBmiState) {
      bmiValue = state.bmiValue;
    }
    return bmiValue;
  }

  BmiLevel getBmiLevel(BmiState state) {
    BmiLevel levelLabel = BmiLevel.empty;
    if (state is InitialState) {
      levelLabel = state.bmiLevel;
    }
    if (state is CalculatedBmiState) {
      levelLabel = state.bmiLevel;
    }
    return levelLabel;
  }

  @override
  void dispose() {
    _bmiBloc.close();
    super.dispose();
  }
}
