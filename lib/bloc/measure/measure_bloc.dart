import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bank_sampah_mobile/model/user.dart';
import 'package:bank_sampah_mobile/model/measure.dart';
import 'package:bank_sampah_mobile/repository/trash_repository.dart';
import 'package:bank_sampah_mobile/repository/measure_repository.dart';

part 'measure_event.dart';
part 'measure_state.dart';

class MeasureBloc extends Bloc<MeasureEvent, MeasureState> {
  final TrashRepository _trashRepository;
  final MeasureRepository _measureRepository;

  MeasureBloc(this._measureRepository, this._trashRepository)
      : super(MeasureInitial());

  @override
  Stream<MeasureState> mapEventToState(
    MeasureEvent event,
  ) async* {
    if (event is GetMeasure) {
      try {
        yield MeasureIsLoading(event.uri);

        final measure = await _measureRepository.getMeasure(event.uri);

        yield MeasureIsLoaded(measure);
      } catch (err) {
        yield MeasureIsError(err.toString());
      }
    } else if (event is PostMeasure) {
      try {
        yield MeasureIsPostLoading();

        final user = await _trashRepository.postTrash(
          event.userId,
          event.isCan,
          event.poin,
          event.trashName,
        );

        SharedPreferences _prefs = await SharedPreferences.getInstance();

        _prefs.setInt('poin', user.results.poin);

        yield MeasureIsPostLoaded(user);
      } catch (err) {
        yield MeasureIsError(err.toString());
      }
    }
  }
}
