import 'package:chat_application/common/storage/app_storage.dart';
import 'package:chat_application/features/auth/login/data/service/login_service.dart';
import 'package:chat_application/features/auth/login/notifier/login_state_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

typedef LoginStateProvider
    = NotifierProvider<LoginStateNotifier, LoginStateModel>;

class LoginStateNotifier extends Notifier<LoginStateModel> {
  final LoginService _loginService = LoginService();
  final AppStorage _storage = GetIt.I.get<AppStorage>();
  @override
  LoginStateModel build() {
    // TODO: implement build
    return LoginStateModel();
  }

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, isSuccess: false, isFailed: false);

    try {
      final model = await _loginService.login(email: email, password: password);
      _storage.saveToken(model.data?.token ?? "");
      _storage.saveUserId(model.data?.user?.id ?? "");
      state = state.copyWith(
        isLoading: false,
        login: model,
        isFailed: false,
        isSuccess: true,
      );
    } catch (e) {
      if (e is DioException) {
        final errorResponse = e.response?.data;
        if (errorResponse is Map && errorResponse['message'] != null) {
          state = state.copyWith(
            isLoading: false,
            isFailed: true,
            errorMessage: errorResponse['message'],
            isSuccess: false,
          );
        } else {
          state = state.copyWith(
            isLoading: false,
            isFailed: true,
            errorMessage: 'Unknown error',
            isSuccess: false,
          );
        }
      } else {
        state = state.copyWith(
          isLoading: false,
          isFailed: true,
          errorMessage: "Server Error",
          isSuccess: false,
        );
      }
    }
  }
}
