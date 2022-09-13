import 'package:bloc/bloc.dart';
import 'package:gontop_buyer/Data/Model/AddFund/FundResponse.dart';
import 'package:gontop_buyer/Data/Model/FunrdTransfer/FundTransferResponse.dart';
import 'package:meta/meta.dart';

import '../../Data/Model/Order/OrderResponse.dart';
import '../../Data/Model/Wallet/UserWalletResponse.dart';
import '../../Repository/OrderRepository/order_repository.dart';
import '../../Repository/WalletRepository/wallet_repository.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletRepository walletRepository =WalletRepository();
  OrderRepository orderRepository=OrderRepository();
  WalletCubit() : super(WalletInitial());

  void createwalletRequest(String? token, String? methos, String? sellerId, String? sellerphone, String? userId, String bkashNum, String transectioId, String ammount) {
    walletRepository.createwalletRequest(token,methos,sellerId,sellerphone,userId,bkashNum,transectioId,ammount).then((value) {
      if(value!=null){
        emit(WalletRequestCreated());
      }
    });
  }

  void getUserWallet(String? token, String? id) {
    walletRepository.getUserWallet(token,id).then((value) {
      if(value!=null){
        emit(WalletUser(walletResponse: value));
      }
    });
  }

  void getUserOrders(String? token, String? userId, String status) {
    orderRepository.getUserOrders(token,userId,status).then((value) {
      if(value!=null){
        emit(OrderHistoryComplete(orderResponse: value));
      }
    });
  }

  void getFunTransferHistory(String? token, String? userId) {
    walletRepository.getFunTransferHistory(token,userId).then((value) {
      if(value!=null){
        emit(FundTransferHistory(fundTransferResponse: value));
      }
    });
  }
  void getAddFunTransferHistory(String? token, String? userId) {
    walletRepository.getAddFunTransferHistory(token,userId).then((value) {
      if(value!=null){
        emit(FundAddedTransferHistory(fundResponse:  value));
      }
    });
  }
}
