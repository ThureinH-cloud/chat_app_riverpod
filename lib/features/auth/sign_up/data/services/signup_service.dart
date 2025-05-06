import 'package:chat_application/common/const/url_const.dart';
import 'package:chat_application/di/locator.dart';
import 'package:chat_application/features/auth/sign_up/data/model/sign_up_model.dart';
import 'package:dio/dio.dart';

class SignUpService {
  final Dio _dio = getIt.get();
  Future<SignUp> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    final res = await _dio.post(UrlConst.signup,
        data: {"name": name, "email": email, "password": password});
    return SignUp.fromJson(res.data);
  }
}
