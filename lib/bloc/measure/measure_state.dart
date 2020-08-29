part of 'measure_bloc.dart';

abstract class MeasureState extends Equatable {
  const MeasureState();

  @override
  List<Object> get props => [];
}

class MeasureInitial extends MeasureState {}

class MeasureIsLoading extends MeasureState {
  final String uri;

  MeasureIsLoading(this.uri);
  @override
  List<Object> get props => [uri];
}

class MeasureIsLoaded extends MeasureState {
  final Measure measure;

  MeasureIsLoaded(this.measure);

  @override
  List<Object> get props => [measure];
}

class MeasureIsPostLoading extends MeasureState {

}

class MeasureIsPostLoaded extends MeasureState {
  final User user;

  MeasureIsPostLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class MeasureIsError extends MeasureState {
  final String message;

  MeasureIsError(this.message);

  @override
  List<Object> get props => [message];
}
