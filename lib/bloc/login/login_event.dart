part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class PostLogin extends LoginEvent {
  final String _email;
  final String _password;

  PostLogin(this._email, this._password);

  @override
  List<Object> get props => [_email, _password];
}
