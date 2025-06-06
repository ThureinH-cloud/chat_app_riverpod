import 'package:chat_application/features/auth/login/pages/login_page.dart';
import 'package:chat_application/features/auth/otp/pages/otp_page.dart';
import 'package:chat_application/features/auth/sign_up/pages/sign_up_page.dart';
import 'package:chat_application/features/home/chat_details/page/chat_details.dart';
import 'package:chat_application/features/home/chat_list/page/chat_list_page.dart';
import 'package:chat_application/features/home/contacts/page/contact_page.dart';
import 'package:chat_application/features/home/home_page.dart';
import 'package:chat_application/features/home/settings/page/setting_page.dart';
import 'package:chat_application/features/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) {
        return HomePage(shell: shell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: "contact",
              path: '/contact',
              builder: (context, state) {
                return ContactPage();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: "chat-list",
              path: '/chat-list',
              builder: (context, state) {
                return ChatListPage();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: "settings",
              path: '/settings',
              builder: (context, state) {
                return SettingPage();
              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      name: "splash",
      path: '/',
      builder: (context, state) {
        return SplashScreen();
      },
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) {
        return LoginPage();
      },
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) {
        return SignUpPage();
      },
    ),
    GoRoute(
      path: '/otp',
      builder: (context, state) {
        final email = state.extra as String;
        return OtpPage(
          email: email,
        );
      },
    ),
    GoRoute(
      name: "chat-details",
      path: "/chat-details",
      builder: (context, state) {
        return ChatDetailsPage();
      },
    )
  ],
);
