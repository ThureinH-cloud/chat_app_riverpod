import '../data/model/otp_model.dart';

class OtpStateModel {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailed;
  final Otp? otp;
  final String? errorMessage;
  OtpStateModel(
      {this.isLoading = false,
      this.isSuccess = false,
      this.isFailed = false,
      this.otp,
      this.errorMessage});
  OtpStateModel copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailed,
    Otp? otp,
    String? errorMessage,
  }) {
    return OtpStateModel(
        isLoading: isLoading ?? this.isLoading,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailed: isFailed ?? this.isFailed,
        otp: otp ?? this.otp,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
