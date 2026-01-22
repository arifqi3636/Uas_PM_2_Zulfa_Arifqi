class Harvest {
  String id;
  final String pondId;
  final double weight;
  final String unit;
  final DateTime date;
  final double pricePerKg;
  final String notes;

  Harvest({
    required this.id,
    required this.pondId,
    required this.weight,
    required this.unit,
    required this.date,
    required this.pricePerKg,
    required this.notes,
  });

  factory Harvest.fromMap(Map<String, dynamic> map, String id) {
    return Harvest(
      id: id,
      pondId: map['pondId'],
      weight: map['weight'],
      unit: map['unit'],
      date: DateTime.parse(map['date']),
      pricePerKg: map['pricePerKg'],
      notes: map['notes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pondId': pondId,
      'weight': weight,
      'unit': unit,
      'date': date.toIso8601String(),
      'pricePerKg': pricePerKg,
      'notes': notes,
    };
  }

  double get totalValue => weight * pricePerKg;
}