import 'package:chat_application/features/auth/otp/data/model/otp_model.dart';
import 'package:chat_application/features/auth/otp/data/services/otp_service.dart';
import 'package:chat_application/features/auth/otp/notifier/otp_state_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef OTPStateProvider = NotifierProvider<OtpStateNotifier, OtpStateModel>;

class OtpStateNotifier extends Notifier<OtpStateModel> {
  final OtpService _otpService = OtpService();
  @override
  OtpStateModel build() {
    // TODO: implement build
    return OtpStateModel();
  }

  Future<void> otpVerify({
    required String email,
    required String otp,
  }) async {
    state = state.copyWith(isLoading: true, isSuccess: false);
    try {
      final Otp model = await _otpService.emailVerify(email: email, otp: otp);
      state = state.copyWith(isLoading: false, otp: model, isSuccess: true);
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
