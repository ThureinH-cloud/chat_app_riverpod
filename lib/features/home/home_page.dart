import 'package:chat_application/common/theme/extension/color_brand.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  final StatefulNavigationShell shell;

  const HomePage({super.key, required this.shell});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    StatefulNavigationShell shell = widget.shell;
    int selectedIndex = shell.currentIndex;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    ColorBrand colorBrand = Theme.of(context).extension<ColorBrand>()!;
    TextTheme textTheme = TextTheme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: shell,
      bottomNavigationBar: NavigationBar(
        elevation: 1,
        height: 48,
        backgroundColor: colorScheme.surface,
        selectedIndex: shell.currentIndex,
        destinations: [
          InkWell(
            onTap: () {
              shell.goBranch(0);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (selectedIndex == 0)
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Contacts",
                            style: textTheme.bodyMedium
                                ?.copyWith(color: colorBrand.brandDefault),
                          ),
                          Icon(
                            Icons.circle,
                            size: 8,
                            color: colorBrand.brandDefault,
                          )
                        ],
                      ),
                    ),
                  if (selectedIndex != 0)
                    Icon(
                      Icons.people,
                      color: colorScheme.onSurface,
                    ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              shell.goBranch(1);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (selectedIndex == 1)
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Chats",
                            style: textTheme.bodyMedium
                                ?.copyWith(color: colorBrand.brandDefault),
                          ),
                          Icon(
                            Icons.circle,
                            size: 8,
                            color: colorBrand.brandDefault,
                          )
                        ],
                      ),
                    ),
                  if (selectedIndex != 1)
                    Icon(
                      Icons.chat_bubble_outline_outlined,
                      color: colorScheme.onSurface,
                    ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              shell.goBranch(2);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (selectedIndex == 2)
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "More",
                            style: textTheme.bodyMedium
                                ?.copyWith(color: colorBrand.brandDefault),
                          ),
                          Icon(
                            Icons.circle,
                            size: 8,
                            color: colorBrand.brandDefault,
                          )
                        ],
                      ),
                    ),
                  if (selectedIndex != 2) Icon(Icons.more_horiz),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
