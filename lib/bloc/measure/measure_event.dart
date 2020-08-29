part of 'measure_bloc.dart';

abstract class MeasureEvent extends Equatable {
  const MeasureEvent();

  @override
  List<Object> get props => [];
}

class GetMeasure extends MeasureEvent {
  final String uri;

  GetMeasure(this.uri);

  @override
  List<Object> get props => [uri];
}

class PostMeasure extends MeasureEvent {
  final String userId;
  final String isCan;
  final String poin;
  final String trashName;

  PostMeasure(this.userId, this.isCan, this.poin, this.trashName);

  @override
  List<Object> get props => [userId, isCan, poin, trashName];
}