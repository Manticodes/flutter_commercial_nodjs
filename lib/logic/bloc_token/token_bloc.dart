import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'token_event.dart';
part 'token_state.dart';

class TokenBloc extends Bloc<TokenEvent, TokenState> {
  TokenBloc() : super(TokenInitial(token: '')) {
    on<GetToken>((event, emit) {
      emit(TokenState(token: event.token));
    });
  }
}
