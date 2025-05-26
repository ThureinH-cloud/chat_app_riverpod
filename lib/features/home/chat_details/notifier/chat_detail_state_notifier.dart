import 'package:chat_application/features/home/chat_details/model/send_message_model.dart';
import 'package:chat_application/features/home/chat_details/notifier/chat_detail_state_model.dart';
import 'package:chat_application/features/home/chat_details/service/chat_detail_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef ChatDetailProvider
    = NotifierProvider<ChatDetailStateNotifier, ChatDetailStateModel>;

class ChatDetailStateNotifier extends Notifier<ChatDetailStateModel> {
  final ChatDetailService _detailService = ChatDetailService();
  @override
  ChatDetailStateModel build() {
    // TODO: implement build
    return ChatDetailStateModel();
  }

  Future<void> sendMessage(
      {required String content, required String chatId}) async {
    try {
      SendMessageModel model =
          await _detailService.sendMessage(chatId: chatId, content: content);
    } catch (e) {
      return Future.error(e);
    }
  }
}
