import 'package:chat_application/di/locator.dart';
import 'package:dio/dio.dart';

import '../../../../../common/const/url_const.dart';
import '../model/contact.dart';

class ContactServices {
  final Dio _dio = getIt.get<Dio>(instanceName: "auth");
  Future<Contact> getContacts({String search = ''}) async {
    String params = search.trim().isEmpty ? '' : '=$search';
    final response = await _dio.get(UrlConst.search + params);
    return Contact.fromJson(response.data);
  }
}
