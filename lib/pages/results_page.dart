import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  ResultPage({required this.bmi});
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
            Text(
              'Your BMI is:',
            ),
            Text(
              bmi.toStringAsFixed(2),
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ],
        ),
      ),
    );
  }
}