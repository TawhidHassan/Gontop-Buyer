part of 'order_cubit.dart';

@immutable
abstract class OrderState {}

class OrderInitial extends OrderState {}
class OrderCreated extends OrderState {}
class OrderHistory extends OrderState {
  final OrderResponse? orderResponse;

  OrderHistory({this.orderResponse});
}
