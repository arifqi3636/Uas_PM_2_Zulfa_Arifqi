class Pond {
  String id;
  final String name;
  final double length;
  final double width;
  final double depth;
  final String status; // healthy, moderate, unhealthy
  final String imageUrl;

  Pond({
    required this.id,
    required this.name,
    required this.length,
    required this.width,
    required this.depth,
    required this.status,
    required this.imageUrl,
  });

  double get volume => length * width * depth;

  factory Pond.fromJson(Map<String, dynamic> json) {
    return Pond(
      id: json['id'],
      name: json['name'],
      length: json['length'],
      width: json['width'],
      depth: json['depth'],
      status: json['status'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'length': length,
      'width': width,
      'depth': depth,
      'status': status,
      'imageUrl': imageUrl,
    };
  }

  factory Pond.fromMap(Map<String, dynamic> map, String id) {
    return Pond(
      id: id,
      name: map['name'],
      length: map['length'],
      width: map['width'],
      depth: map['depth'],
      status: map['status'],
      imageUrl: map['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'length': length,
      'width': width,
      'depth': depth,
      'status': status,
      'imageUrl': imageUrl,
    };
  }
}