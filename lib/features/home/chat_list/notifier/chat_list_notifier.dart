import 'package:chat_application/features/home/chat_list/data/model/chat_list_model.dart';
import 'package:chat_application/features/home/chat_list/data/services/chat_list_service.dart';
import 'package:chat_application/features/home/chat_list/notifier/chat_list_state_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef ChatListNotifierProvider
    = NotifierProvider<ChatListNotifier, ChatListStateModel>;

class ChatListNotifier extends Notifier<ChatListStateModel> {
  final ChatListService _service = ChatListService();
  @override
  ChatListStateModel build() {
    // TODO: implement build
    return ChatListStateModel();
  }

  void getAllChats() async {
    state = state.copyWith(isLoading: true, isFailed: false, isSuccess: false);
    try {
      ChatListModel model = await _service.getAllChat();
      state = state.copyWith(
          chatListModel: model, isSuccess: true, isLoading: false);
    } catch (e) {
      state =
          state.copyWith(isSuccess: false, isFailed: true, isLoading: false);
    }
  }
}
