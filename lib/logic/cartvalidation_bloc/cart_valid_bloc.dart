import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'cart_valid_event.dart';
part 'cart_valid_state.dart';

class CartValidBloc extends Bloc<CartValidEvent, CartValidState> {
  CartValidBloc() : super(const CartValidInitial(isValid: true)) {
    on<GetValidationList>(_getValidationList);
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
}
