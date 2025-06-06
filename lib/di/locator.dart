import 'package:chat_application/common/const/url_const.dart';
import 'package:chat_application/common/storage/app_storage.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.I;
Future<void> setupLocator() async {
  Dio dio = Dio();
  dio.options.baseUrl = UrlConst.baseUrl;
  dio.interceptors.add(PrettyDioLogger());
  getIt.registerSingleton(dio);
  Dio auth = Dio();
  auth.options.baseUrl = UrlConst.baseUrl;
  auth.interceptors.add(PrettyDioLogger());
  auth.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      options.headers['Authorization'] =
          'Bearer ${getIt<AppStorage>().getToken()}';
      return handler.next(options);
    },
  ));
  getIt.registerSingleton(auth, instanceName: "auth");
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  getIt.registerSingleton(AppStorage());
}
