import 'package:chat_application/common/storage/app_storage.dart';
import 'package:chat_application/common/theme/extension/color_brand.dart';
import 'package:chat_application/common/theme/extension/color_neutral.dart';
import 'package:chat_application/common/web_socket/chat_socket.dart';
import 'package:chat_application/features/home/chat_details/model/message_model.dart';
import 'package:chat_application/features/home/chat_details/notifier/chat_detail_state_model.dart';
import 'package:chat_application/features/home/chat_details/notifier/chat_detail_state_notifier.dart';
import 'package:chat_application/features/home/contacts/data/model/create_chat.dart'
    hide Data;
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class ChatDetailsPage extends ConsumerStatefulWidget {
  const ChatDetailsPage({super.key});

  @override
  ConsumerState<ChatDetailsPage> createState() => _ChatDetailsPageState();
}

class _ChatDetailsPageState extends ConsumerState<ChatDetailsPage> {
  final AppStorage _appStorage = GetIt.I.get<AppStorage>();
  Users? _otherUser;
  CreateChat? _createChatModel;

  final TextEditingController _messageController = TextEditingController();
  final ChatDetailProvider _provider = ChatDetailProvider(
    () => ChatDetailStateNotifier(),
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ChatSocket.connect();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GoRouterState state = GoRouterState.of(context);
      _createChatModel = state.extra as CreateChat;
      _getChatUser(_createChatModel);
      String? id = _createChatModel?.data?.id;
      if (id != null) {
        ref.read(_provider.notifier).getAllMessages(id);
        ChatSocket.emit(cmd: ChatSocket.joinRoom, data: id);
        ChatSocket.listen(
            cmd: ChatSocket.newMessage,
            callback: (v) {
              print("new Message is arrived");
              ref.read(_provider.notifier).getAllMessages(id);
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = TextTheme.of(context);
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    ColorBrand colorBrand = Theme.of(context).extension<ColorBrand>()!;
    ColorNeutral colorNeutral = Theme.of(context).extension<ColorNeutral>()!;
    ChatDetailStateModel model = ref.watch(_provider);
    bool? isLoading = model.isLoading;
    bool? isSuccess = model.isSuccess;
    bool? isFailed = model.isFailed;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _otherUser?.name ?? "",
          style: textTheme.bodyLarge,
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoading == true)
                  const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                if (isSuccess == true)
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      itemCount: model.messageModel?.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        Data? chat = model.messageModel?.data![index];
                        String? senderId = chat?.sender?.id;
                        bool isOwnMessage = senderId == _appStorage.getUserId();
                        return BubbleSpecialThree(
                          isSender: isOwnMessage,
                          text: chat?.content ?? "",
                          tail: isOwnMessage,
                          textStyle: textTheme.bodyMedium!.copyWith(
                            color: isOwnMessage
                                ? colorNeutral.buttonText
                                : colorScheme.onSurface,
                          ),
                          color: isOwnMessage
                              ? colorBrand.brandDefault
                              : colorScheme.surface,
                        );
                        // return Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Container(
                        //       width: MediaQuery.of(context).size.width * 0.8,
                        //       padding: EdgeInsets.all(12),
                        //       decoration: BoxDecoration(
                        //         color: Colors.pink,
                        //       ),
                        //       child: Expanded(
                        //         child: Text(
                        //           chat?.content ?? "",
                        //           style: textTheme.bodyMedium?.copyWith(
                        //             color: colorScheme.onSurface,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       height: 10,
                        //     ),
                        //   ],
                        // );
                      },
                    ),
                  ),
                if (isFailed == true)
                  Center(
                    child: Text("Failed To Load"),
                  )
              ],
            ),
          ),
          Row(
            spacing: 4,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextField(
                    controller: _messageController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: colorScheme.surfaceContainerHighest,
                      hintText: "Type a message",
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: _messageController.text.trim().isEmpty
                    ? null
                    : () async {
                        try {
                          if (_otherUser?.id != null) {
                            final data =
                                await ref.read(_provider.notifier).sendMessage(
                                      content: _messageController.text,
                                      chatId: _createChatModel?.data?.id ?? "",
                                    );
                            ChatSocket.emit(
                              cmd: ChatSocket.sendMessage,
                              data: data?.toJson(),
                            );
                            _messageController.clear();
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Fail to send")));
                          }
                        }
                      },
                icon: Icon(
                  Icons.send_outlined,
                  color: colorBrand.brandDefault,
                ),
              )
            ],
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

  void _getChatUser(CreateChat? model) {
    List<Users> users = model?.data?.users ?? [];
    String myId = _appStorage.getUserId();
    if (users.isNotEmpty && users.length == 2) {
      Users otherUser = users.firstWhere((user) => user.id != myId);
      setState(() {
        _otherUser = otherUser;
      });
    }
  }
}
