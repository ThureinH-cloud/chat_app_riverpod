import 'package:chat_application/common/storage/app_storage.dart';
import 'package:chat_application/features/home/chat_list/data/model/chat_list_model.dart';
import 'package:chat_application/features/home/chat_list/notifier/chat_list_notifier.dart';
import 'package:chat_application/features/home/chat_list/notifier/chat_list_state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../contacts/data/model/create_chat.dart' hide Data, Users;
import '../../contacts/notifier/contact_notifier.dart';

class ChatListPage extends ConsumerStatefulWidget {
  const ChatListPage({super.key});

  @override
  ConsumerState<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends ConsumerState<ChatListPage> {
  final ChatListNotifierProvider _provider = ChatListNotifierProvider(
    () => ChatListNotifier(),
  );
  final ContactProvider _contactProvider = ContactProvider(
    () => ContactNotifier(),
  );
  final AppStorage _appStorage = GetIt.I.get<AppStorage>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(_provider.notifier).getAllChats();
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = TextTheme.of(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    ChatListStateModel state = ref.watch(_provider);
    ChatListNotifier notifier = ref.read(_provider.notifier);
    List<Data>? chats = state.chatListModel?.data;
    return Column(
      children: [
        if (state.isLoading == true)
          Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        if (state.isSuccess == true)
          Expanded(
            child: ListView.builder(
              itemCount: chats?.length,
              itemBuilder: (context, index) {
                Data model = chats!.firstWhere(
                    (chat) => chat.users![index].id != _appStorage.getUserId());
                Users user = model.users![index];
                LatestMessage? message = model.latestMessage;
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Card(
                    color: Colors.white,
                    child: ListTile(
                      onTap: () {
                        _createChat(id: user.id);
                      },
                      title: Text(
                        user.name ?? "",
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      subtitle: Text(
                        message?.content ?? "",
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
      ],
    );
  }

  void _createChat({String? id}) async {
    ContactNotifier notifier = ref.read(_contactProvider.notifier);
    showDialog(
        context: context,
        useRootNavigator: false,
        builder: (_) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        });
    try {
      CreateChat chatModel = await notifier.createChat(
        userId: id ?? "",
      );
      if (mounted) {
        context.push("/chat-details", extra: chatModel);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    } finally {
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }
}
