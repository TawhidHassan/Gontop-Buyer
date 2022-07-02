part of 'category_cubit.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}
class CategoryCreated extends CategoryState {}
class GetAllCartegory extends CategoryState {
  final CategoryResponse? categoryResponse;

  GetAllCartegory({this.categoryResponse});
}