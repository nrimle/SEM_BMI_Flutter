import 'package:flutter/material.dart';
import 'package:sem_bmi_flutter/model/measurement.dart';
import 'package:sem_bmi_flutter/pages/results_page.dart';
import 'package:sem_bmi_flutter/services/calculate_service.dart';
import 'package:sem_bmi_flutter/services/database_service.dart';

class InputPage extends StatefulWidget {
  InputPage({required this.title});

  final String title;

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final DatabaseService dbService = DatabaseService();

  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  // Function to calculate BMI and navigate to the result page
  void calculateBMI() async {
    // Create a measurement object from the input values
    var m = Measurement(
        height: double.parse(heightController.text),
        weight: double.parse(weightController.text));
    
    // Calculate BMI
    double bmi = Calculateservice.calculateBMI(m);

    // Insert the measurement into the database
    await dbService.insertMeasurement(m);

    // Navigate to the result page
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
            // Input field for height
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
            // Input field for weight
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
            // Button to calculate BMI
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: calculateBMI,
                child: Text('Calculate'),
              ),
            ),
            // Widget to display BMI information
            BmiInfo()
          ],
        ),
      ),
    );
  }
}

class BmiInfo extends StatelessWidget {
  const BmiInfo({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch theme data
    final theme = Theme.of(context);
    
    // Define text styles based on theme
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
          // Title of the BMI info section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'BMI in brief',
              style: titleStyle,
            ),
          ),
          const SizedBox(height: 20),
          // Description of BMI
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
