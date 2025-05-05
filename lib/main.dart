import 'package:chat_application/common/routes/routes.dart';
import 'package:chat_application/common/theme/theme_const.dart';
import 'package:chat_application/di/locator.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeConst.lightTheme(),
      darkTheme: ThemeConst.darkTheme(),
      routerConfig: router,
    );
  }
}
