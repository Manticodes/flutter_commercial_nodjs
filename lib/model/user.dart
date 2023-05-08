import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String password;
  final String adress;
  final String type;
  final String token;
  final String email;

  const User(
      {required this.id,
      required this.name,
      required this.password,
      required this.adress,
      required this.type,
      required this.token,
      required this.email});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'password': password});
    result.addAll({'adress': adress});
    result.addAll({'type': type});
    result.addAll({'token': token});
    result.addAll({'email': email});

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'],
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      password: map['password'] ?? '',
      adress: map['adress'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  // TODO: implement props
  List<Object?> get props => [email, id, name, password, adress, type, token];
}
