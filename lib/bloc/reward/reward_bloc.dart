import 'dart:async';

import 'package:bank_sampah_mobile/model/reward.dart';
import 'package:bank_sampah_mobile/repository/reward_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'reward_event.dart';
part 'reward_state.dart';

class RewardBloc extends Bloc<RewardEvent, RewardState> {
  final RewardRepository _rewardRepository;

  RewardBloc(this._rewardRepository) : super(RewardInitial());

  @override
  Stream<RewardState> mapEventToState(
    RewardEvent event,
  ) async* {
    if (event is GetReward) {
      try {
        yield RewardIsLoading();

        final reward = await _rewardRepository.getReward();

        yield RewardIsLoaded(reward);
      } catch (err) {
        yield RewardIsError(err.toString());
      }
    }
  }
}
