part of 'product_cubit.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}
class ProductCreated extends ProductState {}
class GetAllProduct extends ProductState {
  final ProductResponse? productResponse;

  GetAllProduct({this.productResponse});
}
class GetAllGameProduct extends ProductState {
  final ProductResponse? productResponse;

  GetAllGameProduct({this.productResponse});
}
