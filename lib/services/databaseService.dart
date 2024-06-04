import 'dart:async';

import 'package:path/path.dart';
import 'package:sem_bmi_flutter/model/measurement.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;

  static Database? _database;

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'measurements.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE measurements(id INTEGER PRIMARY KEY AUTOINCREMENT, height REAL, weight REAL)',
        );
      },
    );
  }

  Future<void> insertMeasurement(Measurement measurement) async {
    final db = await database;
    await db.insert(
      'measurements',
      measurement.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Measurement>> getMeasurements() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('measurements');
    return List.generate(maps.length, (i) {
      return Measurement.fromMap(maps[i]);
    });
  }

  Future<void> deleteMeasurement(int id) async {
    final db = await database;
    await db.delete(
      'measurements',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateMeasurement(Measurement measurement) async {
    final db = await database;
    await db.update(
      'measurements',
      measurement.toMap(),
      where: 'id = ?',
      whereArgs: [measurement.id],
    );
  }
}
