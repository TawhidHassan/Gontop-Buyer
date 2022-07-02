import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Data/Model/Supply/LogResponse.dart';
import '../../Data/Model/Supply/SupplyResponse.dart';
import '../../Repository/Supply/supply_repository.dart';

part 'supply_state.dart';

class SupplyCubit extends Cubit<SupplyState> {
  SupplyRepository supplyRepository=SupplyRepository();
  SupplyCubit() : super(SupplyInitial());

  void getAllSellerMainLogs(String? token) {
    supplyRepository.getAllSellerMainLogs(token).then((value) => {
      if(value!=null){
        emit(GetAllSellerSupply(supplyResponse: value))
      }
    });
  }

  void createGivenSupply(String? token, String amount, String note, String? userId) {
    supplyRepository.createGivenSupply(token,amount,note,userId).then((value) => {
      if(value!=null){
        emit(SupplyCreated())
      }
    });
  }
  void createTakenSupply(String? token, String amount, String note, String? userId) {
    supplyRepository.createTakenSupply(token,amount,note,userId).then((value) => {
      if(value!=null){
        emit(SupplyCreated())
      }
    });
  }

  void getSellerLog(String? token,String userID) {
    supplyRepository.getAllSellerMainLogs(token).then((value) => {
      if(value!=null){
        emit(GetAllSellerSupply(supplyResponse: value))
      }
    });
  }

  void getFullPAymentLog(String? token,String? userId) {
    supplyRepository.getFullPAymentLog(token,userId).then((value) => {
      if(value!=null){
        emit(GetFullPaymentLog(logResponse:  value))
      }
    });
  }



}
