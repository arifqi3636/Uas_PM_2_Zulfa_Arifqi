class FishInventory {
  String id;
  final String pondId;
  final int quantity;
  final double averageWeight;
  final String date;

  FishInventory({
    required this.id,
    required this.pondId,
    required this.quantity,
    required this.averageWeight,
    required this.date,
  });

  factory FishInventory.fromJson(Map<String, dynamic> json) {
    return FishInventory(
      id: json['id'],
      pondId: json['pondId'],
      quantity: json['quantity'],
      averageWeight: json['averageWeight'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pondId': pondId,
      'quantity': quantity,
      'averageWeight': averageWeight,
      'date': date,
    };
  }

  factory FishInventory.fromMap(Map<String, dynamic> map, String id) {
    return FishInventory(
      id: id,
      pondId: map['pondId'],
      quantity: map['quantity'],
      averageWeight: map['averageWeight'],
      date: map['date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pondId': pondId,
      'quantity': quantity,
      'averageWeight': averageWeight,
      'date': date,
    };
  }
}
