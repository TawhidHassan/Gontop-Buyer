import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Data/Model/Product/ProductResponse.dart';
import '../../Repository/ProductRepository/product_repository.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductRepository productRepository=ProductRepository();
  ProductCubit() : super(ProductInitial());

  void createProduct(String? token, String name,String point,String price, String? id, String? categoryId, File? image) {
    productRepository.createProduct(token,name,point,price,id,categoryId,image).then((value) => {
      if(value !=null){
        emit(ProductCreated())
      }
    });
  }

  void getAllProduct(String? token) {
    productRepository.getAllProduct(token).then((value) =>{
      if(value !=null){
        emit(GetAllProduct(productResponse: value))
      }
    });
  }

  void assignProduct(String? token, String? id, String? userId) {
    productRepository.assignProduct(token,id,userId).then((value) =>{
      if(value !=null){
        emit(ProductCreated())
      }
    });
  }

  void getAllProductsGame(String? token, String? id) {
    productRepository.getAllProductsGame(token,id).then((value) =>{
      if(value !=null){
        emit(GetAllGameProduct(productResponse: value))
      }
    });
  }
}
