
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otlop_app/cubits/cart_states.dart';
import 'package:otlop_app/data/product_model.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState());

  void addProduct(ProductModel product, {int quantity = 1}) {
    final products = List<ProductModel>.from(state.products);
    final quantities = List<int>.from(state.quantities);

    final index = products.indexWhere(
          (p) => p.id == product.id,
    );

    if (index == -1) {
      products.add(product);
      quantities.add(quantity);
    } else {
      quantities[index] += quantity;
    }

    emit(
      CartState(
        products: products,
        quantities: quantities,
      ),
    );
  }

  void increase(int index) {
    final quantities = List<int>.from(state.quantities);

    quantities[index]++;

    emit(
      CartState(
        products: state.products,
        quantities: quantities,
      ),
    );
  }

  void decrease(int index) {
    final products = List<ProductModel>.from(state.products);
    final quantities = List<int>.from(state.quantities);

    if (quantities[index] > 1) {
      quantities[index]--;
    } else {
      products.removeAt(index);
      quantities.removeAt(index);
    }

    emit(
      CartState(
        products: products,
        quantities: quantities,
      ),
    );
  }

  void clearCart() {
    emit(CartState());
  }
}
