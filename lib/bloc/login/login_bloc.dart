import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:bank_sampah_mobile/model/user.dart';
import 'package:bank_sampah_mobile/repository/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;

  LoginBloc(this._userRepository) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is PostLogin) {
      try {
        yield LoginIsLoading(event._email, event._password);
        final _user =
            await _userRepository.postLogin(event._email, event._password);

        yield LoginIsLoaded(_user);
      } catch (_) {
        yield LoginError('Email atau Password Tidak Sesuai');
      }
    }
  }
}
