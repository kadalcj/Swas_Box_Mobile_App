part of 'take_bg_bloc.dart';

abstract class TakeBgState extends Equatable {
  const TakeBgState();
  
  @override
  List<Object> get props => [];
}

class TakeBgInitial extends TakeBgState {}

class TakeBgIsLoading extends TakeBgState {
  final String uri;

  TakeBgIsLoading(this.uri);

  @override
  List<Object> get props => [uri];
}

class TakeBgIsLoaded extends TakeBgState {}

class TakeBgIsError extends TakeBgState {
  final String message;

  TakeBgIsError(this.message);

  @override
  List<Object> get props => [message];
}
