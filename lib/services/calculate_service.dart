import 'package:sem_bmi_flutter/model/measurement.dart';

class Calculateservice {
  static double calculateBMI(Measurement m) {
    var bmi = m.weight / (m.height * m.height/10000);
    return bmi;
  }
}