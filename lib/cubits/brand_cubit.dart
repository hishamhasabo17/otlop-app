import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otlop_app/api/api_service.dart';
import 'package:otlop_app/cubits/brand_states.dart';

class BrandCubit extends Cubit<BrandStates> {
  BrandCubit() : super(BrandLoading());

  final DataService datasource = DataService();

  Future<void> getBrands() async {
    try {
      final brands = await datasource.getBrands();

      emit(BrandSuccess(brands));
    } catch (e) {
      emit(BrandFailure());
    }
  }
}