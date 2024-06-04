import 'package:flutter/material.dart';
import 'package:sem_bmi_flutter/model/measurement.dart';
import 'package:sem_bmi_flutter/services/calculateService.dart';
import 'package:sem_bmi_flutter/services/databaseService.dart';

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
          return ListTile(
            title: Text(Calculateservice.calculateBMI(measurement).toStringAsFixed(2)),
            subtitle: Text('${measurement.height} cm - ${measurement.weight} kg'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteMeasurement(measurement.id!),
            ),
          );
        },
      ),
    );
  }
}