part of 'supply_cubit.dart';

@immutable
abstract class SupplyState {}

class SupplyInitial extends SupplyState {}
class SupplyCreated extends SupplyState {}

class GetAllSellerSupply extends SupplyState {
  final SupplyResponse? supplyResponse;

  GetAllSellerSupply({this.supplyResponse});
}
class GetFullPaymentLog extends SupplyState {
  final LogResponse? logResponse;

  GetFullPaymentLog({this.logResponse});
}

