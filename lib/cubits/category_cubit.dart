import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otlop_app/api/api_service.dart';
import 'package:otlop_app/cubits/category_states.dart';

class CategoryCubit extends Cubit<CategoryStates> {
  CategoryCubit() : super(CategoryLoading());

  final DataService datasource = DataService();

  Future<void> getCategories() async {
    try {
      final categories = await datasource.getCategories();

      emit(CategorySuccess(categories));
    } catch (e) {
      log('Category Cubit Error: $e');
      emit(CategoryFailure());
    }
  }
}