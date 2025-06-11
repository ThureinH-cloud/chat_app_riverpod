import 'dart:async';

import 'package:chat_application/common/theme/extension/color_neutral.dart';
import 'package:chat_application/common/theme/extension/meta_data_text_theme.dart';
import 'package:chat_application/features/home/contacts/data/model/contact.dart';
import 'package:chat_application/features/home/contacts/data/model/create_chat.dart'
    hide Data;
import 'package:chat_application/features/home/contacts/notifier/contact_notifier.dart';
import 'package:chat_application/features/home/contacts/notifier/contact_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';

class ContactPage extends ConsumerStatefulWidget {
  const ContactPage({super.key});

  @override
  ConsumerState<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends ConsumerState<ContactPage> {
  final ContactProvider _provider = ContactProvider(
    () => ContactNotifier(),
  );
  Timer? _debounce;
  late TextEditingController _search;
  late final FocusNode _focusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _search = TextEditingController();
    _focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(_provider.notifier).searchContacts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = TextTheme.of(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final MetaDataTextTheme metaTheme =
        Theme.of(context).extension<MetaDataTextTheme>()!;
    final ColorNeutral colorNeutral =
        Theme.of(context).extension<ColorNeutral>()!;
    ContactState state = ref.watch(_provider);
    ContactNotifier notifier = ref.read(_provider.notifier);
    Contact? contactModel = state.contact;
    return state.isLoading == false
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(
                    left: 18, right: 18, top: 18, bottom: 2),
                child: TextField(
                  controller: _search,
                  focusNode: _focusNode,
                  onChanged: _onSearchChanged,
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                  decoration: InputDecoration(
                    label: Row(
                      spacing: 4,
                      children: [
                        Icon(Icons.search),
                        Text("Search"),
                      ],
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    fillColor: colorScheme.surfaceContainerHighest,
                    filled: true,
                    border: MaterialStateOutlineInputBorder.resolveWith(
                      (_) {
                        return OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none,
                        );
                      },
                    ),
                  ),
                ),
              ),
              if (state.isLoading == false && state.isFailed == false)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 12,
                    ),
                    child: AnimationLimiter(
                      child: RefreshIndicator.adaptive(
                        onRefresh: () async {
                          ref.read(_provider.notifier).searchContacts();
                        },
                        child: ListView.builder(
                          itemCount: contactModel?.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            Data? contact = contactModel?.data?[index];
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: FadeInAnimation(
                                delay: Duration(milliseconds: 200),
                                child: Column(
                                  spacing: 2,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        _createChat(
                                          id: contact?.id,
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        width: double.infinity,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              contact?.name ?? "",
                                              style: textTheme.bodyMedium
                                                  ?.copyWith(
                                                      color: colorScheme
                                                          .onSurface),
                                            ),
                                            Text(
                                              contact?.email ?? "",
                                              style:
                                                  metaTheme.metaData1.copyWith(
                                                color: colorScheme
                                                    .onSurfaceVariant,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      color: colorNeutral.neutralLine,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              if (state.isLoading == false && state.isFailed == true)
                Center(
                  child: Text(
                    state.errorMessage ?? "Server Error",
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                )
            ],
          )
        : Center(
            child: CircularProgressIndicator.adaptive(),
          );
  }

  void _createChat({String? id}) async {
    ContactNotifier notifier = ref.read(_provider.notifier);
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

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 600), () {
      ref.read(_provider.notifier).searchContacts(search: value.trim());
    });
    _search.text = value;
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _search.dispose();
    _focusNode.dispose();

    super.dispose();
  }
}
