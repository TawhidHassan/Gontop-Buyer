import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Data/Model/Catgory/CategoryResponse.dart';
import '../../Repository/CategoryRepository/category_repository.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());
  CategoryRepository categoryRepository=CategoryRepository();
  void createCategory(String? token, String name, String? id) {
    categoryRepository.createCategory(token, name, id).then((value) => {
      if(value !=null){
        emit(CategoryCreated())
      }
    });
  }

  void getCategories(String? token) {
    categoryRepository.getCategorys(token).then((value) => {
      if(value !=null){
        emit(GetAllCartegory(categoryResponse: value))
      }
    });
  }

  void getCategorieById(String? token, String? id) {
    categoryRepository.getCategorieById(token,id).then((value) => {
      if(value !=null){
        emit(GetAllCartegory(categoryResponse: value))
      }
    });
  }
}
