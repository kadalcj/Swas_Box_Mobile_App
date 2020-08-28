import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bank_sampah_mobile/model/user.dart';
import 'package:bank_sampah_mobile/repository/user_repository.dart';

part 'refresh_poin_event.dart';
part 'refresh_poin_state.dart';

class RefreshPoinBloc extends Bloc<RefreshPoinEvent, RefreshPoinState> {
  final UserRepository _userRepository;

  RefreshPoinBloc(this._userRepository) : super(RefreshPoinInitial());

  @override
  Stream<RefreshPoinState> mapEventToState(
    RefreshPoinEvent event,
  ) async* {
    if (event is RefreshPoin) {
      try {
        yield RefreshPoinIsLoading(event.userId);

        final user = await _userRepository.postUserId(event.userId);

        SharedPreferences _prefs = await SharedPreferences.getInstance();

        _prefs.setInt('poin', user.results.poin);

        yield RefreshPoinIsLoaded(user);
      } catch (err) {
        yield RefreshPoinIsError(err.toString());
      }
    }
  }
}
