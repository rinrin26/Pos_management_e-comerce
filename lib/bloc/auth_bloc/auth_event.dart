part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthRegister extends AuthEvent {
  final String email;
  final String password;

  AuthRegister({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  AuthLogin({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class AuthUpdated extends AuthEvent {
  final User userData;

  AuthUpdated({required this.userData});

  @override
  List<Object?> get props => [userData];
}

class AuthLogout extends AuthEvent {}

class AuthCheckLogIn extends AuthEvent {
  const AuthCheckLogIn();

  @override
  List<Object?> get props => [];
}
