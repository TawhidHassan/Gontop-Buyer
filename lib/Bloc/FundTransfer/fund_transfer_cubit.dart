import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Repository/WalletRepository/wallet_repository.dart';

part 'fund_transfer_state.dart';

class FundTransferCubit extends Cubit<FundTransferState> {
  WalletRepository walletRepository =WalletRepository();
  FundTransferCubit() : super(FundTransferInitial());

  void unfriend(String? token, String? userId, String? id, String ammount, String messege) {
    walletRepository.unfriend(token,userId,id,ammount,messege).then((value) => {
      if(value !=null){
        emit(FundTransferDone())
      }
    });
  }




}
