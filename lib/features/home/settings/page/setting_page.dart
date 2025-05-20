import 'package:chat_application/common/theme/extension/color_neutral.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = TextTheme.of(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    ColorNeutral colorNeutral = Theme.of(context).extension<ColorNeutral>()!;
    return Column(
      spacing: 12,
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: colorNeutral.neutralLine,
            child: Icon(
              Icons.person_outlined,
              color: colorScheme.onSurface,
              size: 24,
            ),
          ),
          title: Text(
            "Thurein Htet",
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          subtitle: Text("099992929"),
          trailing: Icon(
            Icons.chevron_right_sharp,
            color: colorScheme.onSurface,
          ),
        ),
        Column(
          spacing: 8,
          children: [
            Container(
              padding: EdgeInsets.all(14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    spacing: 8,
                    children: [
                      Icon(
                        Icons.person_outline_outlined,
                        size: 24,
                      ),
                      Text(
                        "Account",
                        style: textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.chevron_right_sharp)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    spacing: 8,
                    children: [
                      Icon(
                        Icons.wb_sunny_outlined,
                        size: 24,
                      ),
                      Text(
                        "Appearance",
                        style: textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.chevron_right_sharp)
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
