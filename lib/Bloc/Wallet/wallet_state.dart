part of 'wallet_cubit.dart';

@immutable
abstract class WalletState {}

class WalletInitial extends WalletState {}
class WalletRequestCreated extends WalletState {}
class WalletUser extends WalletState {
  final UserWalletResponse? walletResponse;

  WalletUser({this.walletResponse});
}
class FundTransferHistory extends WalletState {
  final FundTransferResponse? fundTransferResponse;

  FundTransferHistory({this.fundTransferResponse});
}
class FundAddedTransferHistory extends WalletState {
  final FundResponse? fundResponse;

  FundAddedTransferHistory({this.fundResponse});
}
class OrderHistoryComplete extends WalletState {
  final OrderResponse? orderResponse;

  OrderHistoryComplete({this.orderResponse});
}
