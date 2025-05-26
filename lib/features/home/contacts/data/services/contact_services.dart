import 'package:chat_application/di/locator.dart';
import 'package:chat_application/features/home/contacts/data/model/create_chat.dart';
import 'package:dio/dio.dart';

import '../../../../../common/const/url_const.dart';
import '../model/contact.dart';

class ContactServices {
  final Dio _dio = getIt.get<Dio>(instanceName: "auth");
  // final AppStorage _preferences = getIt.get<AppStorage>();
  Future<Contact> getContacts({String search = ''}) async {
    String params = search.trim().isEmpty ? '' : '=$search';
    final response = await _dio.get(UrlConst.search + params);
    return Contact.fromJson(response.data);
  }

  Future<CreateChat> createChat({required String receiverId}) async {
    // final currentUserId = _preferences.getUserId();
    // final users = [currentUserId, receiverId];
    final response = await _dio.post(
      UrlConst.create_chat,
      data: {
        "users": [receiverId]
      },
    );
    return CreateChat.fromJson(response.data);
  }
}
