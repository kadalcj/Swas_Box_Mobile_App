part of 'reward_bloc.dart';

abstract class RewardState extends Equatable {
  const RewardState();
  
  @override
  List<Object> get props => [];
}

class RewardInitial extends RewardState {}

class RewardIsLoading extends RewardState {}

class RewardIsLoaded extends RewardState {
  final Reward reward;

  RewardIsLoaded(this.reward);

  @override
  List<Object> get props => [reward];
}

class RewardIsError extends RewardState {
  final String message;

  RewardIsError(this.message);

  @override
  List<Object> get props => [message];
}