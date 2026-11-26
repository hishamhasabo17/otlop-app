import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otlop_app/cubits/sign_up_state.dart';
import '../auth_data_source.dart';


class SignupCubit extends Cubit<SignupState> {
  final AuthDataSource authDataSource;

  SignupCubit(this.authDataSource) : super(SignupInitial());

  Future<void> signUp({
    required String name,
    required String email,
    required String pass,
    required String phone,
  }) async {
    emit(SignupLoading());
    try {
      final success = await authDataSource.signUp(
        name: name,
        email: email,
        pass: pass,
        phoneNumber: phone,
      );

      if (success) {
        emit(SignupSuccess());
      } else {
        emit(SignupFailure('فشل إنشاء الحساب'));
      }
    } catch (e) {
      emit(SignupFailure(e.toString()));
    }
  }
}