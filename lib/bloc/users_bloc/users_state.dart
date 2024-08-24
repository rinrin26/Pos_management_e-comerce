part of 'users_bloc.dart';
class UsersState extends Equatable{
  final List<Map<String, dynamic>> users;
  const UsersState({this.users = const []});

  @override
  List<Object> get props => [users];
}