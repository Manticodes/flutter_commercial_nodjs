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

class CleanUser extends UserEvent {
  @override
  List<Object?> get props => [];
}

class LoadUser extends UserEvent {
  @override
  List<Object?> get props => [];
}
