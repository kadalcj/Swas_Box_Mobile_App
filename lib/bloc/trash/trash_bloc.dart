import 'dart:async';

import 'package:bank_sampah_mobile/model/trash.dart';
import 'package:bank_sampah_mobile/repository/trash_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'trash_event.dart';
part 'trash_state.dart';

class TrashBloc extends Bloc<TrashEvent, TrashState> {
  final TrashRepository _trashRepository;

  TrashBloc(this._trashRepository) : super(TrashInitial());

  @override
  Stream<TrashState> mapEventToState(
    TrashEvent event,
  ) async* {
    if (event is GetTrash) {
      try {
        yield TrashIsLoading();

        final trash = await _trashRepository.getTrash();

        yield TrashIsLoaded(trash);
      } catch (_) {
        yield TrashIsError('Something is Wrong');
      }
    }
  }
}
