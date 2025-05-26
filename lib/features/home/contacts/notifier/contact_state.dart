import 'package:chat_application/features/home/contacts/data/model/create_chat.dart';

import '../data/model/contact.dart';

class ContactState {
  bool? isLoading;
  bool? isSuccess;
  bool? isFailed;
  Contact? contact;
  CreateChat? chat;
  String? errorMessage;
  ContactState({
    this.isLoading,
    this.isSuccess,
    this.isFailed,
    this.contact,
    this.chat,
    this.errorMessage,
  });
  ContactState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailed,
    Contact? contact,
    CreateChat? chat,
    String? errorMessage,
  }) {
    return ContactState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailed: isFailed ?? this.isFailed,
      contact: contact ?? this.contact,
      chat: chat ?? this.chat,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
