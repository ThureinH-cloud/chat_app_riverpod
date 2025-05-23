import 'package:chat_application/common/theme/extension/color_brand.dart';
import 'package:chat_application/common/widgets/brand_button.dart';
import 'package:chat_application/features/auth/otp/notifier/otp_state_model.dart';
import 'package:chat_application/features/auth/otp/notifier/otp_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OtpPage extends ConsumerStatefulWidget {
  const OtpPage({super.key, required this.email});
  final String email;
  @override
  ConsumerState<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends ConsumerState<OtpPage> {
  final OTPStateProvider _otpStateProvider = OTPStateProvider(
    () {
      return OtpStateNotifier();
    },
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  void _onChanged(String value, int index) {
    if (value.length == 1 && index < _focusNodes.length - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = TextTheme.of(context);
    ColorBrand colorBrand = Theme.of(context).extension<ColorBrand>()!;
    OtpStateModel state = ref.watch(_otpStateProvider);
    final formkey = GlobalKey<FormState>();
    ref.listen(_otpStateProvider, (previous, next) {
      if (next.isSuccess == true) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (child) {
            return AlertDialog.adaptive(
              title: Text("Success"),
              content: Text(
                next.otp?.message ?? "",
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    context.push("/login");
                  },
                  child: Text("OK"),
                )
              ],
            );
          },
        );
      } else if (next.isFailed == true && previous?.isFailed != true) {
        showDialog(
          context: context,
          builder: (child) {
            return AlertDialog.adaptive(
              icon: Icon(Icons.error),
              title: Text("Error"),
              content: Text(
                next.errorMessage ?? "",
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface,
                ),
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
    return state.isLoading == false
        ? Scaffold(
            appBar: AppBar(
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
                if (state.isLoading)
                  Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                if (state.isLoading == false)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 65,
                        ),
                        Text(
                          "Enter Code",
                          style: textTheme.displayMedium?.copyWith(
                            color: colorScheme.onSurface,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "We have sent you an OTP with the code to ${widget.email}",
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurface,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Form(
                          key: formkey,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              spacing: 12,
                              children: List.generate(
                                4,
                                (index) {
                                  return Expanded(
                                    child: Container(
                                      width: 50,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      child: TextFormField(
                                        controller: _controllers[index],
                                        focusNode: _focusNodes[index],
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        maxLength: 1,
                                        decoration: InputDecoration(
                                          counterText: "",
                                          fillColor: colorScheme
                                              .surfaceContainerHighest,
                                          filled: true,
                                          border:
                                              MaterialStateOutlineInputBorder
                                                  .resolveWith(
                                            (_) {
                                              return OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                borderSide: BorderSide.none,
                                              );
                                            },
                                          ),
                                        ),
                                        onChanged: (value) =>
                                            _onChanged(value, index),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 24,
                          ),
                          child: BrandButton(
                            text: "Verify",
                            onPressed: () async {
                              if (formkey.currentState!.validate()) {
                                String otp = "";
                                for (int i = 0; i < _controllers.length; i++) {
                                  otp += _controllers[i].text;
                                }
                                await ref
                                    .read(_otpStateProvider.notifier)
                                    .otpVerify(
                                      email: widget.email,
                                      otp: otp,
                                    );
                              }
                            },
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            "Resend Code",
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorBrand.brandDefault,
                            ),
                          ),
                        )
                      ],
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
