part of 'invoice_bloc.dart';

abstract class InvoiceEvent extends Equatable {
  const InvoiceEvent();

  @override
  List<Object> get props => [];
}

class PostInvoice extends InvoiceEvent {
  final String _userId;
  final String _rewardId;
  final String _totalItem;

  PostInvoice(this._userId, this._rewardId, this._totalItem);

  @override
  List<Object> get props => [_userId, _rewardId, _totalItem];
}
