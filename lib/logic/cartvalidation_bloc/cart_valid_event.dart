part of 'cart_valid_bloc.dart';

abstract class CartValidEvent extends Equatable {
  const CartValidEvent();
}

class GetValidationList extends CartValidEvent {
  final List<bool> validList;
  const GetValidationList({
    required this.validList,
  });

  @override
  List<Object?> get props => [validList];
}
