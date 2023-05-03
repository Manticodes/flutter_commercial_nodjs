import 'dart:convert';

class Rating {
  final String id;
  final double rate;
  Rating({
    required this.id,
    required this.rate,
  });

  Rating copyWith({
    String? id,
    double? rate,
  }) {
    return Rating(
      id: id ?? this.id,
      rate: rate ?? this.rate,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'rate': rate});

    return result;
  }

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      id: map['userId'] ?? '',
      rate: map['rate']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Rating.fromJson(String source) => Rating.fromMap(json.decode(source));

  @override
  String toString() => 'Rating(id: $id, rate: $rate)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Rating && other.id == id && other.rate == rate;
  }

  @override
  int get hashCode => id.hashCode ^ rate.hashCode;
}
