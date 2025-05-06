import 'package:chat_application/features/auth/login/pages/login_page.dart';
import 'package:chat_application/features/auth/otp/pages/otp_page.dart';
import 'package:chat_application/features/auth/sign_up/pages/sign_up_page.dart';
import 'package:chat_application/features/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
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
        return OtpPage();
      },
    ),
  ],
);
