import 'package:chat_application/common/storage/app_storage.dart';
import 'package:chat_application/common/widgets/brand_button.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AppStorage _appStorage = GetIt.I.get<AppStorage>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = TextTheme.of(context);
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset("assets/images/logo.png"),
                    SizedBox(height: 32),
                    Text(
                      textAlign: TextAlign.center,
                      "Connect easily with your family and friends over countries",
                      style: textTheme.displayMedium?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Terms & Privacy Policy",
                      style: textTheme.bodySmall
                          ?.copyWith(color: colorScheme.onSurface),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    BrandButton(
                      onPressed: () {
                        String token = _appStorage.getToken();
                        if (token.isEmpty) {
                          context.push('/login');
                        } else {
                          context.go("/contact");
                        }
                      },
                      text: "Start Messaging",
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
