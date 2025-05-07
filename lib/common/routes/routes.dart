import 'package:chat_application/features/auth/login/pages/login_page.dart';
import 'package:chat_application/features/auth/otp/pages/otp_page.dart';
import 'package:chat_application/features/auth/sign_up/pages/sign_up_page.dart';
import 'package:chat_application/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return SplashScreen();
      },
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: SplashScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final offset = Tween<Offset>(begin: Offset(1.0, 0), end: Offset.zero)
              .animate(animation);
          final fade = Tween<double>(begin: 0.0, end: 1.0).animate(animation);
          final scale = Tween<double>(begin: 0.9, end: 1.0).animate(animation);

          return SlideTransition(
            position: offset,
            child: FadeTransition(
              opacity: fade,
              child: ScaleTransition(scale: scale, child: child),
            ),
          );
        },
      ),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) {
        return LoginPage();
      },
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: LoginPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final offset = Tween<Offset>(begin: Offset(1.0, 0), end: Offset.zero)
              .animate(animation);
          final fade = Tween<double>(begin: 0.0, end: 1.0).animate(animation);
          final scale = Tween<double>(begin: 0.9, end: 1.0).animate(animation);

          return SlideTransition(
            position: offset,
            child: FadeTransition(
              opacity: fade,
              child: ScaleTransition(scale: scale, child: child),
            ),
          );
        },
      ),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) {
        return SignUpPage();
      },
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: SignUpPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return Align(
            alignment: Alignment.center,
            child: SizeTransition(
              sizeFactor: animation,
              axis: Axis.vertical,
              child: child,
            ),
          );
        },
      ),
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
  ],
);
