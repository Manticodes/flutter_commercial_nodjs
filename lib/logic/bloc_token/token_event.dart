part of 'token_bloc.dart';

abstract class TokenEvent extends Equatable {
  const TokenEvent();
}

class GetToken extends TokenEvent {
  final String token;
  const GetToken({
    required this.token,
  });
  @override
  List<Object?> get props => [token];
}
