import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  ResultPage({
    required this.bmi,
    super.key
  });
  final double bmi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Result'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ResultWidget(bmi: bmi,),
          ],
        ),
      ),
    );
  }
}

class ResultWidget extends StatelessWidget {
  const ResultWidget({
    required this.bmi,
    super.key,
  });
  final double bmi;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final BMIstyle = theme.textTheme.displayLarge!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    final textStyle = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.primary,
    );

    return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'BMI is:',
              style: textStyle,
            ),
          ),
          const SizedBox(height: 20),
          Card(
              color: theme.colorScheme.primary,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  bmi.toStringAsFixed(2),
                  style: BMIstyle,
                ),
              ),
          )
        ],
    );
  }
}