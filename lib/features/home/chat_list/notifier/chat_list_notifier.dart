import 'package:chat_application/features/home/chat_list/notifier/chat_list_state_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatListNotifier extends Notifier<ChatListStateModel> {
  @override
  ChatListStateModel build() {
    // TODO: implement build
    return ChatListStateModel();
  }

  void getAllChats() {
    try {} catch (e) {}
  }
}
