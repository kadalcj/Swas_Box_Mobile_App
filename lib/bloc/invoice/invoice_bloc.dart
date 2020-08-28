import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:bank_sampah_mobile/model/user.dart';
import 'package:bank_sampah_mobile/repository/reward_repository.dart';

part 'invoice_event.dart';
part 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  final RewardRepository _rewardRepository;

  InvoiceBloc(this._rewardRepository) : super(InvoiceInitial());

  @override
  Stream<InvoiceState> mapEventToState(
    InvoiceEvent event,
  ) async* {
    if (event is PostInvoice) {
      try {
        yield InvoiceisLoading(
            event._userId, event._rewardId, event._totalItem);

        final user = await _rewardRepository.postInvoice(
            event._userId, event._rewardId, event._totalItem);

        yield InvoiceIsLoaded(user);
      } catch (err) {
        print(err);
        yield InvoiceIsError(err.toString());
      }
    }
  }
}
