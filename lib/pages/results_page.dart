import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  ResultPage({
    required this.bmi,
    super.key,
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
            CategoryWidget(bmi: bmi),
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

    // Funktion zur Bestimmung der BMI-Kategorie
    String getCategory(double bmi) {
      if (bmi < 16) return "Underweight (Severe thinness)";
      if (bmi >= 16 && bmi < 17) return "Underweight (Moderate thinness)";
      if (bmi >= 17 && bmi < 18.5) return "Underweight (Mild thinness)";
      if (bmi >= 18.5 && bmi < 25) return "Normal range";
      if (bmi >= 25 && bmi < 30) return "Overweight (Pre-obese)";
      if (bmi >= 30 && bmi < 35) return "Obese (Class I)";
      if (bmi >= 35 && bmi < 40) return "Obese (Class II)";
      if (bmi >= 40) return "Obese (Class III)";
      return "Unknown category";
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
        ),
      ],
    );
  }
}
