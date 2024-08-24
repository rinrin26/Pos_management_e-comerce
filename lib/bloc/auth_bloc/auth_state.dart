
part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final User? userData;
  final bool isLoading;
  final String errorMessage;
  final bool loginSuccess; 

  AuthState( {
    this.userData,
    this.isLoading = false,
    this.errorMessage = '',
    this.loginSuccess = false,
  });

  @override
  List<Object?> get props => [userData, isLoading, errorMessage,loginSuccess];
}