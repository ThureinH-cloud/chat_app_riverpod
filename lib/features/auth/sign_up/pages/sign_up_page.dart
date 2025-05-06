import 'package:chat_application/common/theme/extension/color_brand.dart';
import 'package:chat_application/features/auth/sign_up/notifier/sign_up_state_model.dart';
import 'package:chat_application/features/auth/sign_up/notifier/sign_up_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/brand_button.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final SignUpStateProvider _provider = SignUpStateProvider(
    () => SignUpStateNotifier(),
  );
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ColorBrand colorBrand = Theme.of(context).extension<ColorBrand>()!;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    SignUpStateModel state = ref.watch(_provider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Icons.chevron_left,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (state.isLoading == true)
              Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            if (state.isLoading == false)
              Expanded(
                child: Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 80,
                        ),
                        Text(
                          "Enter Your Email",
                          style: textTheme.displayMedium?.copyWith(
                            color: colorScheme.onSurface,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          width: 200,
                          child: Text(
                            "Please enter your email to continue",
                            style: textTheme.bodyLarge?.copyWith(
                              color: colorScheme.onSurface,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _nameController,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Please enter your name";
                              }
                              return null;
                            },
                            style: textTheme.bodyLarge
                                ?.copyWith(color: colorScheme.onSurfaceVariant),
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
                              hintText: "Enter Your Name",
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
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
                            style: textTheme.bodyLarge
                                ?.copyWith(color: colorScheme.onSurfaceVariant),
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
                              hintText: "Enter Your Email",
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Please enter your password";
                              }
                              if (value.length < 6) {
                                return "Password must be at least 6 characters";
                              }
                              return null;
                            },
                            controller: _passwordController,
                            style: textTheme.bodyLarge
                                ?.copyWith(color: colorScheme.onSurfaceVariant),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6),
                                fillColor: colorScheme.surfaceContainerHighest,
                                filled: true,
                                hintText: "Enter Your Password",
                                border:
                                    MaterialStateOutlineInputBorder.resolveWith(
                                  (_) {
                                    return OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: BorderSide.none);
                                  },
                                )),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          BrandButton(
                            text: "Continue",
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ref.read(_provider.notifier).signUp(
                                      name: _nameController.text,
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    );
                                context.push('');
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Please Enter Correctly"),
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
                                "Already have an account?",
                                style: textTheme.bodyMedium
                                    ?.copyWith(color: colorScheme.onSurface),
                              ),
                              InkWell(
                                onTap: () {
                                  context.push("/login");
                                },
                                child: Text(
                                  "Login",
                                  style: textTheme.bodyMedium?.copyWith(
                                      color: colorBrand.brandDefault),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
