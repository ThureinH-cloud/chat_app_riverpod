import 'package:chat_application/common/theme/extension/color_neutral.dart';
import 'package:flutter/material.dart';

import '../theme/extension/color_brand.dart';

class BrandButton extends StatelessWidget {
  const BrandButton({super.key, required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = TextTheme.of(context);
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    ColorBrand colorBrand = Theme.of(context).extension<ColorBrand>()!;
    ColorNeutral colorNeutral = Theme.of(context).extension<ColorNeutral>()!;
    double width = MediaQuery.of(context).size.width;
    return FilledButton(
      style: FilledButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 48),
        fixedSize: Size.fromWidth(width),
        backgroundColor: colorBrand.brandDefault,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: textTheme.bodyLarge?.copyWith(
          color: colorNeutral.buttonText,
        ),
      ),
    );
  }
}
