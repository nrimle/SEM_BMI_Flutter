import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  CategoriesPage({required this.title});

  final String title;

  // Liste der BMI-Kategorien und -Bereiche
  final List<Map<String, dynamic>> bmis = [
    {'Category': 'Underweight (Severe)', 'Range': 'Below 16'},
    {'Category': 'Underweight (Moderate)', 'Range': '16 - 16.9'},
    {'Category': 'Underweight (Mild)', 'Range': '17 - 18.4'},
    {'Category': 'Normal range', 'Range': '18.5 - 24.9'},
    {'Category': 'Overweight', 'Range': '25 - 29.9'},
    {'Category': 'Obese (Class I)', 'Range': '30 - 34.9'},
    {'Category': 'Obese (Class II)', 'Range': '35 - 39.9'},
    {'Category': 'Obese (Class III)', 'Range': '40 or above'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: DataTable(
        // Definieren der Spalten für die DataTable
        columns: [
          DataColumn(label: Text('BMI Range')),
          DataColumn(label: Text('Category')),
        ],
        rows: bmis.map((bmi) => DataRow(cells: [
          DataCell(
            Container(
              width: 80,
              child: Text(bmi['Range']),
            ),
          ),
          DataCell(Text(bmi['Category'])),
        ])).toList(),
      ),
    );
  }
}
