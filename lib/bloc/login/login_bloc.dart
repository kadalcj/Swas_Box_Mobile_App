import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:bank_sampah_mobile/model/user.dart';
import 'package:bank_sampah_mobile/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        final user =
            await _userRepository.postLogin(event._email, event._password);

        SharedPreferences _prefs = await SharedPreferences.getInstance();

        _prefs.setString('_id', user.results.id);
        _prefs.setString('firstName', user.results.firstName);
        _prefs.setInt('poin', user.results.poin);

        yield LoginIsLoaded(user);
      } catch (err) {
        print(err.toString());
        yield LoginError('Email atau Password Tidak Sesuai');
      }
    }
  }
}
