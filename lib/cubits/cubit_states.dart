import '../data/product_model.dart';

abstract class ProductStates {}

class ProductLoading extends ProductStates {}

class ProductSuccess extends ProductStates {
  final List<ProductModel> products;

  ProductSuccess(this.products);
}

class ProductFailure extends ProductStates {}