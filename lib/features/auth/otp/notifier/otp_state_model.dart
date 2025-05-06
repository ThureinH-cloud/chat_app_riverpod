import '../data/model/otp_model.dart';

class OtpStateModel {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailed;
  final Otp? otp;

  OtpStateModel({
    this.isLoading = false,
    this.isSuccess = false,
    this.isFailed = false,
    this.otp,
  });
  OtpStateModel copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailed,
    Otp? otp,
  }) {
    return OtpStateModel(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailed: isFailed ?? this.isFailed,
      otp: otp ?? this.otp,
    );
  }
}
