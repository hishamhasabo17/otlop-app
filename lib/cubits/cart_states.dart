import 'package:otlop_app/data/product_model.dart';

class CartState {
  final List<ProductModel> products;
  final List<int> quantities;

  CartState({
    this.products = const [],
    this.quantities = const [],
  });

  double get subtotal {
    double total = 0;

    for (int i = 0; i < products.length; i++) {
      total += products[i].price * quantities[i];
    }

    return total;
  }

  int get deliveryFee => products.isEmpty ? 0 : 25;

  double get total => subtotal + deliveryFee;
}