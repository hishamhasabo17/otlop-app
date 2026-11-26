abstract class CategoryStates {}

class CategoryLoading extends CategoryStates {}

class CategorySuccess extends CategoryStates {
  final List categories;

  CategorySuccess(this.categories);
}

class CategoryFailure extends CategoryStates {}