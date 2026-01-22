class HealthMonitoring {
  String id;
  final String pondId;
  final String parameter;
  final double value;
  final String status;
  final String date;
  final String notes;

  HealthMonitoring({
    required this.id,
    required this.pondId,
    required this.parameter,
    required this.value,
    required this.status,
    required this.date,
    required this.notes,
  });

  factory HealthMonitoring.fromJson(Map<String, dynamic> json) {
    return HealthMonitoring(
      id: json['id'],
      pondId: json['pondId'],
      parameter: json['parameter'],
      value: json['value'],
      status: json['status'],
      date: json['date'],
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pondId': pondId,
      'parameter': parameter,
      'value': value,
      'status': status,
      'date': date,
      'notes': notes,
    };
  }

  factory HealthMonitoring.fromMap(Map<String, dynamic> map, String id) {
    return HealthMonitoring(
      id: id,
      pondId: map['pondId'],
      parameter: map['parameter'],
      value: map['value'],
      status: map['status'],
      date: map['date'],
      notes: map['notes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pondId': pondId,
      'parameter': parameter,
      'value': value,
      'status': status,
      'date': date,
      'notes': notes,
    };
  }
}