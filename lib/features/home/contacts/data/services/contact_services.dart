import 'package:chat_application/di/locator.dart';
import 'package:dio/dio.dart';

import '../../../../../common/const/url_const.dart';
import '../model/contact.dart';

class ContactServices {
  final Dio _dio = getIt.get<Dio>(instanceName: "auth");
  Future<Contact> getContacts() async {
    final response = await _dio.get(UrlConst.search);
    return Contact.fromJson(response.data);
  }
}
