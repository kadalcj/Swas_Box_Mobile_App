part of 'trash_bloc.dart';

abstract class TrashState extends Equatable {
  const TrashState();

  @override
  List<Object> get props => [];
}

class TrashInitial extends TrashState {}

class TrashIsLoading extends TrashState {}

class TrashIsLoaded extends TrashState {
  final Trash trash;

  TrashIsLoaded(this.trash);

  @override
  List<Object> get props => [trash];
}

class TrashIsError extends TrashState {
  final String message;

  TrashIsError(this.message);

  @override
  List<Object> get props => [message];
}
