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

  String? _name;
  String? _email;
  String? _password;
  @override
  Widget build(BuildContext context) {
    ColorBrand colorBrand = Theme.of(context).extension<ColorBrand>()!;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    SignUpStateModel stateModel = ref.watch(_provider);
    return !stateModel.isLoading
        ? Scaffold(
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
                  if (stateModel.isLoading == false)
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
                                  onSaved: (newValue) {
                                    _name = newValue;
                                  },
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "Please enter your name";
                                    }
                                    return null;
                                  },
                                  style: textTheme.bodyLarge?.copyWith(
                                    color: colorScheme.onSurface,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 6,
                                    ),
                                    fillColor:
                                        colorScheme.surfaceContainerHighest,
                                    filled: true,
                                    border: MaterialStateOutlineInputBorder
                                        .resolveWith(
                                      (_) {
                                        return OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
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
                                  onSaved: (newValue) {
                                    _email = newValue;
                                  },
                                  style: textTheme.bodyLarge?.copyWith(
                                    color: colorScheme.onSurface,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 6),
                                    fillColor:
                                        colorScheme.surfaceContainerHighest,
                                    filled: true,
                                    border: MaterialStateOutlineInputBorder
                                        .resolveWith(
                                      (_) {
                                        return OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
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
                                  onSaved: (newValue) {
                                    _password = newValue;
                                  },
                                  style: textTheme.bodyLarge?.copyWith(
                                    color: colorScheme.onSurface,
                                  ),
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 6,
                                    ),
                                    fillColor:
                                        colorScheme.surfaceContainerHighest,
                                    filled: true,
                                    hintText: "Enter Your Password",
                                    border: MaterialStateOutlineInputBorder
                                        .resolveWith(
                                      (_) {
                                        return OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            borderSide: BorderSide.none);
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                BrandButton(
                                  text: "Continue",
                                  onPressed: () async {
                                    FormState state = _formKey.currentState!;
                                    state.save();
                                    if (state.validate() == true) {
                                      await ref.read(_provider.notifier).signUp(
                                            name: _name!,
                                            email: _email!,
                                            password: _password!,
                                          );
                                      if (stateModel.isSuccess == true) {
                                        Future.delayed(
                                          Duration(seconds: 2),
                                          () => {
                                            if (context.mounted)
                                              {
                                                context.push("otp"),
                                              }
                                          },
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content:
                                                Text(stateModel.errorMessage!),
                                          ),
                                        );
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text("Please Enter Correctly"),
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
                                      style: textTheme.bodyMedium?.copyWith(
                                          color: colorScheme.onSurface),
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
          )
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
