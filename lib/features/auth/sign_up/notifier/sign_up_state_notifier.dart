import 'package:chat_application/features/auth/sign_up/data/model/sign_up_model.dart';
import 'package:chat_application/features/auth/sign_up/data/services/signup_service.dart';
import 'package:chat_application/features/auth/sign_up/notifier/sign_up_state_model.dart';
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

  void signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      state = state.copyWith(isLoading: true);
      SignUp signUp = await _signUpService.signup(
        name: name,
        email: email,
        password: password,
      );
      state = state.copyWith(isLoading: false, signUp: signUp);
    } catch (e) {
      print(e.toString());
      state = state.copyWith(isLoading: false, isFailed: true);
    }
  }
}
