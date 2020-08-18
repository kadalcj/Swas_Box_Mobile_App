import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:bank_sampah_mobile/model/user.dart';
import 'package:bank_sampah_mobile/repository/user_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc(this._userRepository) : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is PostRegister) {
      try {
        yield RegisterIsLoading(event._firstName, event._lastName,
            event._contact, event._email, event._password);
        final user = await _userRepository.postRegister(event._firstName,
            event._lastName, event._contact, event._email, event._password);

        yield RegisterIsLoaded(user);
      } catch (_) {
        yield RegisterError('Terjadi Kesalahan');
      }
    }
  }
}
