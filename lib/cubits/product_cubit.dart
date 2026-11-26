import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otlop_app/api/api_service.dart';
import 'package:otlop_app/cubits/cubit_states.dart';

class ProductCubit extends Cubit<ProductStates> {
  ProductCubit() : super(ProductLoading());

  final DataService datasource = DataService();

  Future<void> getProducts() async {
    try {
      final value = await datasource.getProducts();

      log('Products Length: ${value.length}');

      emit(ProductSuccess(value));
    } catch (e) {
      log('Products Error: $e');
      emit(ProductFailure());
    }
  }
}