import 'dart:async';
import 'package:path/path.dart';
import 'package:sem_bmi_flutter/model/measurement.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  // Singleton-Instanz
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;

  // Datenbank-Referenz
  static Database? _database;

  // Privater Konstruktor für Singleton-Pattern
  DatabaseService._internal();

  // Getter für die Datenbankinstanz
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialisierung der Datenbank
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

  // Einfügen eines Messwerts
  Future<void> insertMeasurement(Measurement measurement) async {
    final db = await database;
    await db.insert(
      'measurements',
      measurement.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Abrufen aller Messwerte
  Future<List<Measurement>> getMeasurements() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('measurements');
    return List.generate(maps.length, (i) {
      return Measurement.fromMap(maps[i]);
    });
  }

  // Löschen eines Messwerts anhand der ID
  Future<void> deleteMeasurement(int id) async {
    final db = await database;
    await db.delete(
      'measurements',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Aktualisieren eines Messwerts
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
