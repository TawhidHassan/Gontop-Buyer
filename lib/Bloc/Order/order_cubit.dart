import 'package:bloc/bloc.dart';
import 'package:gontop_buyer/Repository/WalletRepository/wallet_repository.dart';
import 'package:meta/meta.dart';

import '../../Data/Model/Order/OrderResponse.dart';
import '../../Repository/OrderRepository/order_repository.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderRepository orderRepository=OrderRepository();
  OrderCubit() : super(OrderInitial());

  void createOrder(String? token, String? productId, num price,String? gameId, String ign, String inGameName, String fbMaol, String fbPass) {
    orderRepository.createOrder(token,productId,price,gameId,ign,inGameName,fbPass,fbMaol).then((value) {
      if(value!=null){
        emit(OrderCreated());
      }
    });
  }

  void getUserOrders(String? token, String? userId, String status) {
    orderRepository.getUserOrders(token,userId,status).then((value) {
      if(value!=null){
        emit(OrderHistory(orderResponse: value));
      }
    });
  }
}
