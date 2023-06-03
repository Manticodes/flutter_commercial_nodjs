part of 'cart_valid_bloc.dart';

class CartValidState extends Equatable {
  final bool isValid;
  const CartValidState({required this.isValid});

  @override
  List<Object> get props => [isValid];
}

class CartValidInitial extends CartValidState {
  const CartValidInitial({required super.isValid});
}
