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
            ResultWidget(bmi: bmi),
            CategoryWidget(bmi: bmi)
          ],
        ),
        
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    required this.bmi,
    super.key,
  });
  final double bmi;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    String getCategory(bmi){
      switch(bmi) {
        case <16: return "Underweight (Severe thinness)";
        case >= 16 && < 17: return "Underweight (Moderate thinness)	";
        case >=17 && < 18.5: return "Underweight (Mild thinness)";
        case >=18.5 && < 25: return "Normal range";
        case >=25 && < 30: return "Overweight (Pre-obese)	";
        case >= 30 && < 35: return "Obese (Class I)";
        case >= 35 && < 40: return "Obese (Class II)";
        case >= 40: return "Obese (Class II)";
        default: return "break";
      }
    }
    var category = getCategory(bmi);

    return Card(
        color: theme.colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
              category,
            style: textStyle,
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