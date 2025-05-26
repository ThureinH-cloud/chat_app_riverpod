import '../model/message_model.dart';

class ChatDetailStateModel {
  final bool? isLoading;
  final bool? isSuccess;
  final bool? isFailed;
  final MessageModel? messageModel;
  ChatDetailStateModel({
    this.messageModel,
    this.isLoading = false,
    this.isSuccess = false,
    this.isFailed = false,
  });
  ChatDetailStateModel copyWith({
    MessageModel? messageModel,
    bool? isLoading,
    bool? isSuccess,
    bool? isFailed,
  }) {
    return ChatDetailStateModel(
      messageModel: messageModel ?? this.messageModel,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailed: isFailed ?? this.isFailed,
    );
  }
}
