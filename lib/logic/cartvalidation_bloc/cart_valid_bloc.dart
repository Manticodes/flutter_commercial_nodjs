import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_commercial_nodjs/features/cart/services/services.dart';
import 'package:flutter_commercial_nodjs/logic/bloc_user/user_bloc.dart';

part 'cart_valid_event.dart';
part 'cart_valid_state.dart';

class CartValidBloc extends Bloc<CartValidEvent, CartValidState> {
  CartValidBloc() : super(const CartValidInitial(isValid: true)) {
    on<GetValidationList>(_getValidationList);
    on<CheckValidation>(_checkValidation);
  }

  FutureOr<void> _getValidationList(
      GetValidationList event, Emitter<CartValidState> emit) {
    late bool isValid;
    if (event.validList.contains(false)) {
      isValid = false;
    } else {
      isValid = true;
    }
    emit(CartValidState(isValid: isValid));
  }

  FutureOr<void> _checkValidation(
      CheckValidation event, Emitter<CartValidState> emit) {}
}
