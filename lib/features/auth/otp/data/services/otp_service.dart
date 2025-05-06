import 'package:chat_application/common/const/url_const.dart';
import 'package:chat_application/features/auth/otp/data/model/otp_model.dart';
import 'package:dio/dio.dart';

import '../../../../../di/locator.dart';

class OtpService {
  final Dio _dio = getIt.get();
  Future<Otp> emailVerify({
    required String email,
    required String otp,
  }) async {
    final res = await _dio.post(
      UrlConst.verfiyOtp,
      data: {
        "email": email,
        "otp": otp,
      },
    );
    return Otp.fromJson(res.data);
  }
}
