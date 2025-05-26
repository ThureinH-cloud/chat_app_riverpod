import 'package:chat_application/features/home/chat_details/model/send_message_model.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../../common/const/url_const.dart';

class ChatDetailService {
  final Dio _dio = GetIt.I.get(instanceName: "auth");
  Future<SendMessageModel> sendMessage(
      {required String chatId, required String content}) async {
    final response = await _dio.post(
      UrlConst.send,
      data: {
        "content": content,
        "chat_id": chatId,
      },
    );
    return SendMessageModel.fromJson(response.data);
  }
}
