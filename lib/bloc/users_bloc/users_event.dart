part of 'users_bloc.dart';

sealed class UsersEvent extends Equatable {
  const UsersEvent();
  @override
  List<Object> get props => [];
}

class UsersFetch extends UsersEvent {}

class UsersAdded extends UsersEvent {
  final String uid;
  final String email;
  final String nama;
  final String noHP;

  UsersAdded(
      {required this.uid,
      required this.email,
      required this.nama,
      required this.noHP});
  @override
  List<Object> get props => [uid, email, nama, noHP];
}

class UsersUpdated extends UsersEvent {
  final List<Map<String, dynamic>> users;
  UsersUpdated({required this.users});

  @override
  List<Object> get props => [users];
}
