class Feeding {
  String id;
  final String pondId;
  final String feedId;
  final double quantity;
  final String unit;
  final DateTime date;
  final String notes;

  Feeding({
    required this.id,
    required this.pondId,
    required this.feedId,
    required this.quantity,
    required this.unit,
    required this.date,
    required this.notes,
  });

  factory Feeding.fromMap(Map<String, dynamic> map, String id) {
    return Feeding(
      id: id,
      pondId: map['pondId'],
      feedId: map['feedId'],
      quantity: map['quantity'],
      unit: map['unit'],
      date: DateTime.parse(map['date']),
      notes: map['notes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pondId': pondId,
      'feedId': feedId,
      'quantity': quantity,
      'unit': unit,
      'date': date.toIso8601String(),
      'notes': notes,
    };
  }
}
