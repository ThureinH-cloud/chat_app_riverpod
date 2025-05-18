import 'package:chat_application/features/auth/sign_up/data/model/sign_up_model.dart';
import 'package:chat_application/features/auth/sign_up/data/services/signup_service.dart';
import 'package:chat_application/features/auth/sign_up/notifier/sign_up_state_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef SignUpStateProvider
    = NotifierProvider<SignUpStateNotifier, SignUpStateModel>;

class SignUpStateNotifier extends Notifier<SignUpStateModel> {
  final SignUpService _signUpService = SignUpService();
  @override
  SignUpStateModel build() {
    // TODO: implement build
    return SignUpStateModel();
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      state = state.copyWith(isLoading: true, isSuccess: false);
      SignUp signUp = await _signUpService.signup(
        name: name,
        email: email,
        password: password,
      );
      state = state.copyWith(isLoading: false, signUp: signUp, isSuccess: true);
    } catch (e) {
      if (e is DioException) {
        final errorResponse = e.response?.data;
        if (errorResponse is Map && errorResponse['message'] != null) {
          state = state.copyWith(
            isLoading: false,
            isFailed: true,
            errorMessage: errorResponse['message'],
          );
        } else {
          state = state.copyWith(
            isLoading: false,
            isFailed: true,
            errorMessage: 'Unknown error',
          );
        }
      } else {
        state = state.copyWith(
            isLoading: false, isFailed: true, errorMessage: "Server Error");
      }
    }
  }
}
