import 'package:chat_application/features/home/contacts/data/model/contact.dart';
import 'package:chat_application/features/home/contacts/data/model/create_chat.dart';
import 'package:chat_application/features/home/contacts/data/services/contact_services.dart';
import 'package:chat_application/features/home/contacts/notifier/contact_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef ContactProvider = NotifierProvider<ContactNotifier, ContactState>;

class ContactNotifier extends Notifier<ContactState> {
  final ContactServices _contactServices = ContactServices();
  @override
  ContactState build() {
    // TODO: implement build
    return ContactState();
  }

  void searchContacts({String? search}) async {
    try {
      state =
          state.copyWith(isLoading: true, isFailed: false, isSuccess: false);

      Contact model = await _contactServices.getContacts(search: search ?? "");
      state = state.copyWith(
          isLoading: false, isFailed: false, isSuccess: true, contact: model);
    } catch (e) {
      if (e is DioException && e.response?.data['message'] != null) {
        state = state.copyWith(
            isLoading: false,
            isFailed: true,
            errorMessage: e.response?.data['message']);
      } else {
        state = state.copyWith(
          isLoading: false,
          isFailed: true,
          errorMessage: 'Something wrong',
        );
      }
    }
  }

  Future<CreateChat> createChat({required String userId}) async {
    try {
      CreateChat createChatModel =
          await _contactServices.createChat(receiverId: userId);
      return createChatModel;
    } catch (e) {
      return Future.error(e);
    }
  }
}
