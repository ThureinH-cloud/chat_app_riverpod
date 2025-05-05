import 'package:chat_application/common/theme/extension/color_brand.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/brand_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    ColorBrand colorBrand = Theme.of(context).extension<ColorBrand>()!;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
              TextFormField(
                style: textTheme.bodyLarge
                    ?.copyWith(color: colorScheme.onSurfaceVariant),
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
                  hintText: "Enter Your Name",
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                style: textTheme.bodyLarge
                    ?.copyWith(color: colorScheme.onSurfaceVariant),
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
                  hintText: "Enter Your Email",
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                style: textTheme.bodyLarge
                    ?.copyWith(color: colorScheme.onSurfaceVariant),
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    fillColor: colorScheme.surfaceContainerHighest,
                    filled: true,
                    hintText: "Enter Your Password",
                    border: MaterialStateOutlineInputBorder.resolveWith(
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
                onPressed: () {},
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
                      style: textTheme.bodyMedium
                          ?.copyWith(color: colorBrand.brandDefault),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
