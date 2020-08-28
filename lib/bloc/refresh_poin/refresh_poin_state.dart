part of 'refresh_poin_bloc.dart';

abstract class RefreshPoinState extends Equatable {
  const RefreshPoinState();

  @override
  List<Object> get props => [];
}

class RefreshPoinInitial extends RefreshPoinState {}

class RefreshPoinIsLoading extends RefreshPoinState {
  final String userId;

  RefreshPoinIsLoading(this.userId);

  @override
  List<Object> get props => [userId];
}

class RefreshPoinIsLoaded extends RefreshPoinState {
  final User user;

  RefreshPoinIsLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class RefreshPoinIsError extends RefreshPoinState {
  final String message;

  RefreshPoinIsError(this.message);

  @override
  List<Object> get props => [message];
}
