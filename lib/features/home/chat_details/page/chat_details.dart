import 'package:chat_application/common/storage/app_storage.dart';
import 'package:chat_application/common/theme/extension/color_brand.dart';
import 'package:chat_application/features/home/chat_details/notifier/chat_detail_state_notifier.dart';
import 'package:chat_application/features/home/contacts/data/model/create_chat.dart';
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
  final TextEditingController _messageController = TextEditingController();
  final ChatDetailProvider _provider = ChatDetailProvider(
    () => ChatDetailStateNotifier(),
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GoRouterState state = GoRouterState.of(context);
      CreateChat model = state.extra as CreateChat;
      _getChatUser(model);
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = TextTheme.of(context);
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    ColorBrand colorBrand = Theme.of(context).extension<ColorBrand>()!;
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
            Expanded(child: SizedBox()),
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
                              await ref.read(_provider.notifier).sendMessage(
                                  content: _messageController.text,
                                  chatId: _otherUser?.id ?? "");
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
        ));
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
