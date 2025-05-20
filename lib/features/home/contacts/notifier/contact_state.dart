import '../data/model/contact.dart';

class ContactState {
  bool? isLoading;
  bool? isSuccess;
  bool? isFailed;
  Contact? contact;
  String? errorMessage;
  ContactState({
    this.isLoading,
    this.isSuccess,
    this.isFailed,
    this.contact,
    this.errorMessage,
  });
  ContactState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailed,
    Contact? contact,
    String? errorMessage,
  }) {
    return ContactState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailed: isFailed ?? this.isFailed,
      contact: contact ?? this.contact,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
