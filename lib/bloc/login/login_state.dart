part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginIsLoading extends LoginState {
  final String _email;
  final String _password;

  LoginIsLoading(this._email, this._password);

  @override
  List<Object> get props => [_email, _password];
}

class LoginIsLoaded extends LoginState {
  final User user;

  LoginIsLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class LoginError extends LoginState {
  final String message;

  LoginError(this.message);

  @override
  List<Object> get props => [message];
}
