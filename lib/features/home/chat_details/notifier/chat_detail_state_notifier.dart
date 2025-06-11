import 'package:chat_application/features/home/chat_details/model/message_model.dart'
    hide Data;
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

  Future<Data?> sendMessage(
      {required String content, required String chatId}) async {
    try {
      SendMessageModel model =
          await _detailService.sendMessage(chatId: chatId, content: content);
      return model.data;
    } catch (e) {
      return Future.error(e);
    }
  }

  void getAllMessages(String chatId) async {
    state = state.copyWith(isLoading: true, isFailed: false, isSuccess: false);
    try {
      MessageModel model = await _detailService.getAllMessages(chatId: chatId);
      state = state.copyWith(
          messageModel: model, isSuccess: true, isLoading: false);
    } catch (e) {
      state = state.copyWith(isFailed: true, isLoading: false);
    }
  }
}
