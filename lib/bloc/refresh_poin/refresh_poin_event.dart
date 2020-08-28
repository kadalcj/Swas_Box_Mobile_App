part of 'refresh_poin_bloc.dart';

abstract class RefreshPoinEvent extends Equatable {
  const RefreshPoinEvent();

  @override
  List<Object> get props => [];
}

class RefreshPoin extends RefreshPoinEvent {
  final String userId;

  RefreshPoin(this.userId);

  @override
  List<Object> get props => [userId];
}