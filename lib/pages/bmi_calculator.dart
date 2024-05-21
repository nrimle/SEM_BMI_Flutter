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
    var bmi = weight / (height * height);

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
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter your height in meters',
              ),
            ),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter your weight in kg',
              ),
            ),
            ElevatedButton(
              onPressed: calculateBMI,
              child: Text('Calculate'),
            ),
          ],
        ),
      ),
    );
  }
}

