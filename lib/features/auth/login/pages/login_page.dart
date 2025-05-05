import 'package:chat_application/common/theme/extension/color_brand.dart';
import 'package:chat_application/common/widgets/brand_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorBrand colorBrand = Theme.of(context).extension<ColorBrand>()!;
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
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
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
                hintText: "Email",
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
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
                  )),
            ),
            SizedBox(
              height: 8,
            ),
            BrandButton(
              text: "Login",
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
              height: 98,
            )
          ],
        ),
      ),
    );
  }
}
