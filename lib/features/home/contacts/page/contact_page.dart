import 'dart:async';

import 'package:chat_application/common/theme/extension/color_neutral.dart';
import 'package:chat_application/common/theme/extension/meta_data_text_theme.dart';
import 'package:chat_application/features/home/contacts/data/model/contact.dart';
import 'package:chat_application/features/home/contacts/notifier/contact_notifier.dart';
import 'package:chat_application/features/home/contacts/notifier/contact_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    List<Data>? contacts = state.contact?.data;
    return state.isLoading == false
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
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
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      spacing: 6,
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: contacts?.length,
                            itemBuilder: (context, index) {
                              Data contact = contacts![index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                                // child: ListTile(
                                //   title: Text(
                                //     contact.name ?? "",
                                //     style: textTheme.bodyLarge,
                                //   ),
                                //   subtitle: Text(
                                //     contact.email ?? "",
                                //     style: textTheme.bodyMedium?.copyWith(
                                //       color: colorScheme.onSurfaceVariant,
                                //     ),
                                //   ),
                                // ),
                                child: Column(
                                  spacing: 2,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      contact.name ?? "",
                                      style: textTheme.bodyMedium?.copyWith(
                                          color: colorScheme.onSurface),
                                    ),
                                    Text(
                                      contact.email ?? "",
                                      style: metaTheme.metaData1.copyWith(
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Divider(
                                      color: colorNeutral.neutralLine,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
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

  Widget _buildSearchBar(TextTheme textTheme, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: TextField(
        controller: _search,
        focusNode: _focusNode,
        style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
        decoration: InputDecoration(
          label: Row(
            children: const [
              Icon(Icons.search),
              SizedBox(width: 4),
              Text("Search"),
            ],
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          fillColor: colorScheme.surfaceContainerHighest,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (value) {
          if (value.trim().isEmpty) {
            ref.read(_provider.notifier).searchContacts();
          } else {
            ref.read(_provider.notifier).searchContacts(search: value);
          }
        },
      ),
    );
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
