import 'package:chat_application/features/home/chat_list/data/model/chat_list_model.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../../../common/const/url_const.dart';

class ChatListService {
  final Dio _dio = GetIt.I.get(instanceName: "auth");
  Future<ChatListModel> getAllChat() async {
    final response = await _dio.get(UrlConst.chat_lists);
    return ChatListModel.fromJson(response.data);
  }
}
