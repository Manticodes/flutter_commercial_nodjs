import 'dart:convert';

class Rating {
  final String userId;
  final double rate;
  Rating({
    required this.userId,
    required this.rate,
  });

  Rating copyWith({
    String? userId,
    double? rate,
  }) {
    return Rating(
      userId: userId ?? this.userId,
      rate: rate ?? this.rate,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userId': userId});
    result.addAll({'rate': rate});

    return result;
  }

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      userId: map['userId'] ?? '',
      rate: map['rate']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Rating.fromJson(String source) => Rating.fromMap(json.decode(source));

  @override
  String toString() => 'Rating(userId: $userId, rate: $rate)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Rating && other.userId == userId && other.rate == rate;
  }

  @override
  int get hashCode => userId.hashCode ^ rate.hashCode;
}
