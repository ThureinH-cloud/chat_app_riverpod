import '../data/model/Login.dart';

class LoginStateModel {
  final bool isLoading;
  final bool isFailed;
  final bool isSuccess;
  final Login? login;

  LoginStateModel({
    this.isLoading = false,
    this.isFailed = false,
    this.isSuccess = false,
    this.login,
  });
  LoginStateModel copyWith({
    bool? isLoading,
    bool? isFailed,
    bool? isSuccess,
    Login? login,
  }) {
    return LoginStateModel(
      isLoading: isLoading ?? this.isLoading,
      isFailed: isFailed ?? this.isFailed,
      isSuccess: isSuccess ?? this.isSuccess,
      login: login ?? this.login,
    );
  }
}
