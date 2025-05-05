import 'package:chat_application/common/const/url_const.dart';
import 'package:dio/dio.dart';

Future<void> setupLocator() async {
  Dio dio = Dio();
  dio.options.baseUrl = UrlConst.baseUrl;
}
