import 'package:chat_application/features/auth/login/data/service/login_service.dart';
import 'package:chat_application/features/auth/login/notifier/login_state_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/model/Login.dart';

typedef LoginStateProvider
    = NotifierProvider<LoginStateNotifier, LoginStateModel>;

class LoginStateNotifier extends Notifier<LoginStateModel> {
  final LoginService _loginService = LoginService();
  @override
  LoginStateModel build() {
    // TODO: implement build
    return LoginStateModel();
  }

  Future<bool> userLogin({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true);

    try {
      final model = await _loginService.login(email: email, password: password);
      state = state.copyWith(
        isLoading: false,
        login: model,
        isFailed: false,
      );
      return true;
    } catch (e) {
      if (e is Login) {
        state = state.copyWith(
          isLoading: false,
          login: e,
          isFailed: true,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          isFailed: true,
          login: Login(
            status: false,
            message: e.toString(),
            data: null,
          ),
        );
      }
      return false;
    }
  }
}
