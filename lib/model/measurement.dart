class Measurement {
  int? id;
  double height;
  double weight;

  Measurement({
    this.id,
    required this.height,
    required this.weight,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'height': height,
      'weight': weight,
    };
  }

  @override
  String toString() {
    return 'Measurement{height: $height, weight: $weight}';
  }

  factory Measurement.fromMap(Map<String, dynamic> map) {
    return Measurement(
      id: map['id'],
      height: map['height'],
      weight: map['weight'],
    );
  }
}