part of 'fund_transfer_cubit.dart';

@immutable
abstract class FundTransferState {}

class FundTransferInitial extends FundTransferState {}
class FundTransferDone extends FundTransferState {}
