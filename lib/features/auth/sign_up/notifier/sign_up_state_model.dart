import 'package:chat_application/features/auth/sign_up/data/model/sign_up_model.dart';

class SignUpStateModel {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailed;
  final SignUp? signUp;
  final String? errorMessage;

  SignUpStateModel({
    this.isLoading = false,
    this.isSuccess = false,
    this.isFailed = false,
    this.signUp,
    this.errorMessage,
  });

  SignUpStateModel copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailed,
    SignUp? signUp,
    String? errorMessage,
  }) {
    return SignUpStateModel(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailed: isFailed ?? this.isFailed,
      signUp: signUp ?? this.signUp,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
