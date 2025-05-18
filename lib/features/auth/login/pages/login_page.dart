import 'package:chat_application/common/theme/extension/color_brand.dart';
import 'package:chat_application/common/widgets/brand_button.dart';
import 'package:chat_application/features/auth/login/notifier/login_state_model.dart';
import 'package:chat_application/features/auth/login/notifier/login_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  final _loginStateProvider = LoginStateProvider(
    () => LoginStateNotifier(),
  );

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorBrand colorBrand = Theme.of(context).extension<ColorBrand>()!;
    LoginStateModel state = ref.watch(_loginStateProvider);
    ref.listen(_loginStateProvider, (previous, next) async {
      print("${previous?.isFailed} ${next.isFailed}");
      if (next.isSuccess == true) {
        showDialog(
          context: context,
          barrierDismissible: false, // prevent dismiss before timeout
          builder: (context) {
            return AlertDialog.adaptive(
              content: Column(
                spacing: 4,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                    size: 50,
                  ),
                  Text(
                    next.login?.message ?? "",
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "You will be redirected shortly.",
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  )
                ],
              ),
            );
          },
        );
        await Future.delayed(
          Duration(
            seconds: 3,
          ),
        );
        if (context.mounted) {
          Navigator.of(context).pop();
        }
        if (context.mounted) {
          context.go('/home');
        }
      } else if (next.isFailed == true && previous?.isFailed != true) {
        showDialog(
          context: context,
          builder: (child) {
            return AlertDialog.adaptive(
              content: Column(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                  ),
                  Text(
                    "Error",
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    next.errorMessage ?? "",
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: Text("OK"),
                )
              ],
            );
          },
        );
      }
    });
    return !state.isLoading
        ? Scaffold(
            appBar: AppBar(
              title: Text("Login"),
              centerTitle: false,
              leading: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Icon(Icons.chevron_left),
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state.isLoading == false)
                  Expanded(
                    child: Form(
                      key: _formkey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 32,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Spacer(),
                            TextFormField(
                              onSaved: (newValue) {
                                _email = newValue;
                              },
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Please enter your email";
                                }
                                if (!RegExp(
                                        r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                                  return "Please enter a valid email";
                                }
                                return null;
                              },
                              style: textTheme.bodyLarge?.copyWith(
                                color: colorScheme.onSurface,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6),
                                fillColor: colorScheme.surfaceContainerHighest,
                                filled: true,
                                border:
                                    MaterialStateOutlineInputBorder.resolveWith(
                                  (_) {
                                    return OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide.none,
                                    );
                                  },
                                ),
                                hintText: "Email",
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              onSaved: (newValue) {
                                _password = newValue;
                              },
                              style: textTheme.bodyLarge?.copyWith(
                                color: colorScheme.onSurface,
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Please enter your password";
                                }
                                if (value.trim().length < 6) {
                                  return "Password must be at least 6 characters";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6),
                                fillColor: colorScheme.surfaceContainerHighest,
                                filled: true,
                                hintText: "Password",
                                border:
                                    MaterialStateOutlineInputBorder.resolveWith(
                                  (_) {
                                    return OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: BorderSide.none);
                                  },
                                ),
                              ),
                              obscureText: true,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            BrandButton(
                              text: "Login",
                              onPressed: () async {
                                FormState formState = _formkey.currentState!;
                                formState.save();
                                if (formState.validate()) {
                                  await ref
                                      .read(_loginStateProvider.notifier)
                                      .userLogin(
                                        email: _email!,
                                        password: _password!,
                                      );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text("Please fill all the fields"),
                                    ),
                                  );
                                }
                              },
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 8,
                              children: [
                                Text(
                                  "New user?",
                                  style: textTheme.bodyMedium
                                      ?.copyWith(color: colorScheme.onSurface),
                                ),
                                InkWell(
                                  onTap: () {
                                    context.push("/signup");
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: textTheme.bodyMedium?.copyWith(
                                        color: colorBrand.brandDefault),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Spacer()
                          ],
                        ),
                      ),
                    ),
                  )
              ],
            ),
          )
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
  }
}
