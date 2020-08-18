part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
  
  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterIsLoading extends RegisterState {
  final String _firstName;
  final String _lastName;
  final String _contact;
  final String _email;
  final String _password;

  RegisterIsLoading(this._firstName, this._lastName, this._contact, this._email, this._password);

  @override
  List<Object> get props => [_firstName, _lastName, _contact, _email, _password];
}

class RegisterIsLoaded extends RegisterState {
  final User _user;

  RegisterIsLoaded(this._user);

  @override
  List<Object> get props => [_user];
}

class RegisterError extends RegisterState {
  final String message;

  RegisterError(this.message);

  @override
  List<Object> get props => [message];
}