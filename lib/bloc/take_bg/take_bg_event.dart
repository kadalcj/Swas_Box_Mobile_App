part of 'take_bg_bloc.dart';

abstract class TakeBgEvent extends Equatable {
  const TakeBgEvent();

  @override
  List<Object> get props => [];
}

class TakeBg extends TakeBgEvent {
  final String uri;

  TakeBg(this.uri);

  @override
  List<Object> get props => [uri];
}
