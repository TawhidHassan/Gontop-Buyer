import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Repository/WalletRepository/wallet_repository.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletRepository walletRepository =WalletRepository();
  WalletCubit() : super(WalletInitial());

  void createwalletRequest(String? token, String? methos, String? sellerId, String? sellerphone, String? userId, String bkashNum, String transectioId, String ammount) {
    walletRepository.createwalletRequest(token,methos,sellerId,sellerphone,userId,bkashNum,transectioId,ammount).then((value) {
      if(value!=null){
        emit(WalletRequestCreated());
      }
    });
  }
}
