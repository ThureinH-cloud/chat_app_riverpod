import 'package:chat_application/common/theme/extension/color_brand.dart';
import 'package:chat_application/common/theme/extension/color_neutral.dart';
import 'package:chat_application/common/theme/extension/meta_data_text_theme.dart';
import 'package:flutter/material.dart';

class ThemeConst {
  static ThemeData lightTheme() {
    ThemeData light = ThemeData.light();
    return light.copyWith(
        appBarTheme: AppBarTheme(backgroundColor: Color(0xffFFFFFF)),
        scaffoldBackgroundColor: Color(0xffFFFFFF),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.blue,
          selectionColor: Colors.lightBlue.shade100, // Highlighted background
          selectionHandleColor: Colors.blueAccent,
        ),
        textTheme: light.textTheme
            .copyWith(displayMedium: displayMedium, bodyMedium: bodyMedium),
        colorScheme: light.colorScheme.copyWith(
          surface: Color(0xffffffff),
          onSurface: Color(0xff0F1828),
          surfaceContainerHighest: Color(0xffF7F7FC),
          onSurfaceVariant: Color(0xffADB5BD),
        ),
        extensions: [
          ColorBrand(
            brandDefault: Color(0xff002DE3),
            brandBackground: Color(0xffD2D5F9),
          ),
          ColorNeutral(
            neutralLine: Color(0xffEDEDED),
            buttonText: Color(0xffFFFFFF),
          ),
          _metaDataTextTheme
        ]);
  }

  static ThemeData darkTheme() {
    ThemeData dark = ThemeData.dark();
    return dark.copyWith(
        appBarTheme: AppBarTheme(backgroundColor: Color(0xff0F1828)),
        scaffoldBackgroundColor: Color(0xff0F1828),
        textTheme: dark.textTheme
            .copyWith(displayMedium: displayMedium, bodyMedium: bodyMedium),
        colorScheme: dark.colorScheme.copyWith(
          surface: Color(0xff0F1828),
          onSurface: Color(0xffFFFFFF),
          surfaceContainerHighest: Color(0xff152033),
          onSurfaceVariant: Color(0xffADB5BD),
        ),
        extensions: [
          ColorBrand(
            brandDefault: Color(0xff002DE3),
            brandBackground: Color(0xffD2D5F9),
          ),
          ColorNeutral(
            neutralLine: Color(0xffF7F7FC),
            buttonText: Color(0xffFFFFFF),
          ),
          _metaDataTextTheme
        ]);
  }

  static final MetaDataTextTheme _metaDataTextTheme = MetaDataTextTheme(
    metaData1: TextStyle(
      fontSize: 12,
    ),
    metaData2: TextStyle(
      fontSize: 10,
    ),
    metaData3: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
  );
  static final displayMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static final bodyMedium = TextStyle(fontSize: 14);
}
