import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc()
      : super(const UserInitial(
            user: User(
                adress: '',
                email: '',
                id: '',
                name: '',
                password: '',
                token: '',
                type: '',
                cart: []))) {
    on<SetUser>(_onSetUser);
    on<CleanUser>(_onCleanUser);
    on<AddToCart>(_onAddToCart);
    on<LoadUser>(_onLoadUser);
    on<AddAddress>(_onAddAddress);
    on<ClearCart>(_onClearCart);
  }

  FutureOr<void> _onSetUser(SetUser event, Emitter<UserState> emit) {
    User user = User.fromJson(event.user);
    emit(UserState(user: user));
  }

  FutureOr<void> _onCleanUser(CleanUser event, Emitter<UserState> emit) {
    emit(const UserState(
        user: User(
            adress: '',
            email: '',
            id: '',
            name: '',
            password: '',
            token: '',
            type: '',
            cart: [])));
  }

  FutureOr<void> _onAddToCart(AddToCart event, Emitter<UserState> emit) {
    emit(UserState(
        user: state.user.copyWith(cart: jsonDecode(event.user)['cart'])));
  }

  FutureOr<void> _onLoadUser(LoadUser event, Emitter<UserState> emit) {
    emit(UserState(user: state.user));
  }

  FutureOr<void> _onAddAddress(AddAddress event, Emitter<UserState> emit) {
    emit(UserState(user: state.user.copyWith(adress: event.adrress)));
  }

  FutureOr<void> _onClearCart(ClearCart event, Emitter<UserState> emit) {
    emit(UserState(user: state.user.copyWith(cart: [])));
  }
}
