class Feed {
  String id;
  final String name;
  final String type;
  final double quantity;
  final String unit;
  final double price;
  final String date;

  Feed({
    required this.id,
    required this.name,
    required this.type,
    required this.quantity,
    required this.unit,
    required this.price,
    required this.date,
  });

  factory Feed.fromJson(Map<String, dynamic> json) {
    return Feed(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      quantity: json['quantity'],
      unit: json['unit'],
      price: json['price'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'quantity': quantity,
      'unit': unit,
      'price': price,
      'date': date,
    };
  }

  factory Feed.fromMap(Map<String, dynamic> map, String id) {
    return Feed(
      id: id,
      name: map['name'],
      type: map['type'],
      quantity: map['quantity'],
      unit: map['unit'],
      price: map['price'],
      date: map['date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'quantity': quantity,
      'unit': unit,
      'price': price,
      'date': date,
    };
  }
}
