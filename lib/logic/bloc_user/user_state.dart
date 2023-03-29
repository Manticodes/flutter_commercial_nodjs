part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState({
    required this.user,
  });
  final User user;

  @override
  List<Object> get props => [user];
}

class UserInitial extends UserState {
  const UserInitial({required super.user});
}
