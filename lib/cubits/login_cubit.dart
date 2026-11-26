import 'package:flutter_bloc/flutter_bloc.dart';
import '../auth_data_source.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthDataSource authDataSource;

  LoginCubit(this.authDataSource) : super(LoginInitial());

  Future<void> login({required String email, required String pass}) async {
    emit(LoginLoading());
    try {
      final success = await authDataSource.login(email: email, pass: pass);
      if (success) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure('فشل تسجيل الدخول'));
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}