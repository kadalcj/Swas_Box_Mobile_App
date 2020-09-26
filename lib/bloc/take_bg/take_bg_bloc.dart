import 'dart:async';

import 'package:bank_sampah_mobile/repository/measure_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'take_bg_event.dart';
part 'take_bg_state.dart';

class TakeBgBloc extends Bloc<TakeBgEvent, TakeBgState> {
  final MeasureRepository _measureRepository;

  TakeBgBloc(this._measureRepository) : super(TakeBgInitial());

  @override
  Stream<TakeBgState> mapEventToState(
    TakeBgEvent event,
  ) async* {
    if (event is TakeBg) {
      try {
        yield TakeBgIsLoading(event.uri);

        await _measureRepository.takeBackground(event.uri);

        yield TakeBgIsLoaded();
      } catch (err) {
        yield TakeBgIsError(err.toString());
      }
    }
  }
}
