import 'package:flutter/material.dart';
import 'package:sem_bmi_flutter/model/measurement.dart';
import 'package:sem_bmi_flutter/pages/results_page.dart';
import 'package:sem_bmi_flutter/services/calculate_service.dart';
import 'package:sem_bmi_flutter/services/database_service.dart';

class HistoryPage extends StatelessWidget {
  final DatabaseService dbService = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MeasurementScreen(),
    );
  }
}

class MeasurementScreen extends StatefulWidget {
  @override
  _MeasurementScreenState createState() => _MeasurementScreenState();
}

class _MeasurementScreenState extends State<MeasurementScreen> {
  final DatabaseService dbService = DatabaseService();
  List<Measurement> measurements = [];

  @override
  void initState() {
    super.initState();
    _loadMeasurements();
  }

  void _loadMeasurements() async {
    final data = await dbService.getMeasurements();
    setState(() {
      measurements = data;
    });
  }

  void _deleteMeasurement(int id) async {
    await dbService.deleteMeasurement(id);
    _loadMeasurements();
  }

  void _openDetails(double bmi) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResultPage(bmi: bmi)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Measurements'),
      ),
      body: ListView.builder(
        itemCount: measurements.length,
        itemBuilder: (context, index) {
          final measurement = measurements[index];
          final bmi = Calculateservice.calculateBMI(measurement);

          return ListTile(
            title: Text(bmi.toStringAsFixed(2)),
            subtitle: Text('${measurement.height} cm - ${measurement.weight} kg'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteMeasurement(measurement.id!),
            ),
            onTap: () => _openDetails(bmi),
          );
        },
      ),
    );
  }
}