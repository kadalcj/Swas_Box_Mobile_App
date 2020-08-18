part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class PostRegister extends RegisterEvent {
  final String _firstName;
  final String _lastName;
  final String _contact;
  final String _email;
  final String _password;

  PostRegister(this._firstName, this._lastName, this._contact, this._email, this._password);

  @override
  List<Object> get props => [_firstName, _lastName, _contact, _email, _password];
}