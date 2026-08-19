import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_care/presentations/widgets/CodeValidateField.dart';
import 'package:plant_care/presentations/widgets/MainButton.dart';

import '../../../controllers/cubit/user_cubit/user_cubit.dart';
import '../../themes/app_button_theme.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_theme.dart';
import 'UpdatePasswordScreen.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key, required this.email});

  final String? email;

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final code1Controller = TextEditingController();
  final code2Controller = TextEditingController();
  final code3Controller = TextEditingController();
  final code4Controller = TextEditingController();
  final code5Controller = TextEditingController();
  final code6Controller = TextEditingController();
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  final focus4 = FocusNode();
  final focus5 = FocusNode();
  final focus6 = FocusNode();

  String get enteredCode {
    return code1Controller.text +
        code2Controller.text +
        code3Controller.text +
        code4Controller.text +
        code5Controller.text +
        code6Controller.text;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is VerifyCodeSuccess) {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (_) => UpdatePasswordScreen(resetToken: state.resetToken),
            ),
          );
        }

        if (state is VerifyCodeError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },

      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: AppTheme.plantCareAILogo(),
              leading: AppTheme.backButton(context),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Reset Password",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: CodeValidateField(
                            controller: code1Controller,
                            focusNode: focus1,
                          ),
                        ),

                        SizedBox(width: 8.w),

                        Expanded(
                          child: CodeValidateField(
                            controller: code2Controller,
                            focusNode: focus2,
                            previousFocus: focus1,
                          ),
                        ),

                        SizedBox(width: 8.w),

                        Expanded(
                          child: CodeValidateField(
                            controller: code3Controller,
                            focusNode: focus3,
                            previousFocus: focus2,
                          ),
                        ),

                        SizedBox(width: 8.w),

                        Expanded(
                          child: CodeValidateField(
                            controller: code4Controller,
                            focusNode: focus4,
                            previousFocus: focus3,
                          ),
                        ),

                        SizedBox(width: 8.w),

                        Expanded(
                          child: CodeValidateField(
                            controller: code5Controller,
                            focusNode: focus5,
                            previousFocus: focus4,
                          ),
                        ),

                        SizedBox(width: 8.w),

                        Expanded(
                          child: CodeValidateField(
                            controller: code6Controller,
                            focusNode: focus6,
                            previousFocus: focus5,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 10.w),

                        Expanded(
                          child: MainButton(
                            mainAxisSize: MainAxisSize.max,
                            content: "Confirm",
                            onPressed: () {
                              final code = enteredCode;
                              if (code.length == 6) {
                                context.read<UserCubit>().verifyCode(
                                  widget.email!,
                                  code,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Please enter a valid code"),
                                  ),
                                );
                              }
                            },
                            textStyle: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w500,
                                ),
                            buttonStyle: AppButtonTheme.theme.style!.copyWith(),
                          ),
                        ),
                        SizedBox(width: 24.w),
                        Expanded(
                          child: MainButton(
                            mainAxisSize: MainAxisSize.max,
                            content: "Resend",
                            onPressed: () {
                              context.read<UserCubit>().forgotPassword(
                                widget.email!,
                              );
                            },
                            textStyle: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w500,
                                ),
                            buttonStyle: AppButtonTheme.themeSecondary.style!
                                .copyWith(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    focus1.requestFocus();
  }

  @override
  void dispose() {
    code1Controller.dispose();
    code2Controller.dispose();
    code3Controller.dispose();
    code4Controller.dispose();
    code5Controller.dispose();
    code6Controller.dispose();

    focus1.dispose();
    focus2.dispose();
    focus3.dispose();
    focus4.dispose();
    focus5.dispose();
    focus6.dispose();
    super.dispose();
  }
}
