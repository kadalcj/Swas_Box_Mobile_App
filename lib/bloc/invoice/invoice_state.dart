part of 'invoice_bloc.dart';

abstract class InvoiceState extends Equatable {
  const InvoiceState();

  @override
  List<Object> get props => [];
}

class InvoiceInitial extends InvoiceState {}

class InvoiceisLoading extends InvoiceState {
  final String _userId;
  final String _rewardId;
  final String _totalItem;

  InvoiceisLoading(this._userId, this._rewardId, this._totalItem);

  @override
  List<Object> get props => [_userId, _rewardId, _totalItem];
}

class InvoiceIsLoaded extends InvoiceState {
  final User user;

  InvoiceIsLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class InvoiceIsError extends InvoiceState {
  final String message;

  InvoiceIsError(this.message);

  @override
  List<Object> get props => [message];
}
