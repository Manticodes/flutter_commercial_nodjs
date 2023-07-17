part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class SetUser extends UserEvent {
  final String user;
  const SetUser({
    required this.user,
  });

  @override
  List<Object?> get props => [user];
}

class AddToCart extends UserEvent {
  final String user;
  const AddToCart({
    required this.user,
  });

  @override
  List<Object?> get props => [user];
}

class ClearCart extends UserEvent {
  @override
  List<Object?> get props => [];
}

class AddAddress extends UserEvent {
  final String adrress;
  const AddAddress({
    required this.adrress,
  });

  @override
  List<Object?> get props => [adrress];
}

class CleanUser extends UserEvent {
  @override
  List<Object?> get props => [];
}

class LoadUser extends UserEvent {
  @override
  List<Object?> get props => [];
}

class ChangeOrderStatus extends UserEvent {
  @override
  List<Object?> get props => [];
}
