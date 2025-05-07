import 'package:chat_application/common/const/url_const.dart';
import 'package:chat_application/di/locator.dart';
import 'package:dio/dio.dart';

import '../model/Login.dart';

class LoginService {
  final Dio _dio = getIt.get();
  Future<Login> login({
    required String email,
    required String password,
  }) async {
    final res = await _dio.post(UrlConst.login, data: {
      'email': email,
      'password': password,
    });
    return Login.fromJson(res.data);
  }
}
