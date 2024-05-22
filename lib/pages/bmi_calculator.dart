import 'package:flutter/material.dart';
import 'package:sem_bmi_flutter/pages/results_page.dart';

class InputPage extends StatefulWidget {
  InputPage({required this.title});

  final String title;

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final weightController = TextEditingController();
  final heightController = TextEditingController();

  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  void calculateBMI() {
    var height = double.parse(heightController.text);
    var weight = double.parse(weightController.text);
    var bmi = weight / (height * height/10000);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResultPage(bmi: bmi)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your height in cm',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your weight in kg',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: calculateBMI,
                child: Text('Calculate'),
              ),
            ),
            BmiInfo()
          ],
        ),
      ),
    );
  }
}

class BmiInfo extends StatelessWidget {
  const BmiInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    final textStyle = theme.textTheme.bodyMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'BMI in brief',
              style: titleStyle,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Body Mass Index (BMI) is a measure calculated from a person's weight and height to categorize them as underweight, normal weight, overweight, or obese. It provides a simple estimate of body fat but doesn't account for muscle mass or other factors. Despite its limitations, BMI is widely used in assessing health risks.",
              style: textStyle,
            ),
          ),
        ],
      ),
    );
  }
}
