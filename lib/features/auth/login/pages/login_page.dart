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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final LoginStateProvider _loginStateProvider = LoginStateProvider(
    () {
      return LoginStateNotifier();
    },
  );

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorBrand colorBrand = Theme.of(context).extension<ColorBrand>()!;
    LoginStateModel state = ref.watch(_loginStateProvider);
    return Scaffold(
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
          if (state.isLoading == true)
            Center(
              child: CircularProgressIndicator.adaptive(),
            ),
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
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter your email";
                          }
                          if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                        style: textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                          fillColor: colorScheme.surfaceContainerHighest,
                          filled: true,
                          border: MaterialStateOutlineInputBorder.resolveWith(
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
                        controller: _passwordController,
                        style: textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onSurfaceVariant,
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
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                          fillColor: colorScheme.surfaceContainerHighest,
                          filled: true,
                          hintText: "Password",
                          border: MaterialStateOutlineInputBorder.resolveWith(
                            (_) {
                              return OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide.none);
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      BrandButton(
                        text: "Login",
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            final result = await ref
                                .read(_loginStateProvider.notifier)
                                .userLogin(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                            if (result == true) {
                              context.go("/home");
                            } else {
                              final errorMessage = ref
                                      .read(_loginStateProvider)
                                      .login
                                      ?.message ??
                                  'Login failed';
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(errorMessage)),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Please fill all the fields"),
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
                              style: textTheme.bodyMedium
                                  ?.copyWith(color: colorBrand.brandDefault),
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
    );
  }
}
