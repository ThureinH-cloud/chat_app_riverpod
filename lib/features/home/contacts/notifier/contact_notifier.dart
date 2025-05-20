import 'package:chat_application/features/home/contacts/data/model/contact.dart';
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

  Future<void> searchContacts() async {
    state = state.copyWith(isLoading: true, isFailed: false, isSuccess: false);
    try {
      Contact model = await _contactServices.getContacts();
      state = state.copyWith(
          isLoading: false, isFailed: false, isSuccess: true, contact: model);
    } catch (e) {
      if (e is DioException) {}
    }
  }
}
