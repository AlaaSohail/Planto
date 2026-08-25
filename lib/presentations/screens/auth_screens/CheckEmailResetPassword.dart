import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_care/presentations/widgets/AuthTextField.dart';
import 'package:plant_care/presentations/widgets/MainButton.dart';

import '../../../controllers/cubit/user_cubit/user_cubit.dart';
import '../../themes/app_button_theme.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_theme.dart';
import '../../widgets/ContainerIcons.dart';
import 'VerifyCodeScreen.dart';

class CheckEmailResetPassword extends StatefulWidget {
  const CheckEmailResetPassword({super.key, this.email});

  final String? email;

  @override
  State<CheckEmailResetPassword> createState() =>
      _CheckEmailResetPasswordState();
}

class _CheckEmailResetPasswordState extends State<CheckEmailResetPassword> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
  final _formKey = GlobalKey<FormState>();

  late final emailController = TextEditingController(text: widget.email ?? '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppTheme.plantCareAILogo(),
        leading: AppTheme.backButton(context),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0).r,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      "Enter your email you registered with to reset your password.",
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(color: AppColors.textPrimary),
                    ),
                    SizedBox(height: 20.h),
                    AuthTextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,

                      validator: (value) {
                        if (value!.isEmpty || value == null || value == "") {
                          return "Enter your email";
                        }
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(value)) {
                          return "Enter valid email";
                        }

                        return null;
                      },

                      prefix: ContainerIcons(icon: "assets/images/at.png"),
                      obscureText: false,
                      hintText: "example@alaasohail.com",
                    ),

                    SizedBox(height: 20.h),
                    MainButton(
                      content: "Continue",
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }

                        context.read<UserCubit>().forgotPassword(
                          emailController.text.trim(),
                        );

                        if (!mounted) return;

                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (_) => VerifyCodeScreen(
                              email: emailController.text.trim(),
                            ),
                          ),
                        );
                      },

                      mainAxisSize: MainAxisSize.max,
                      textStyle: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                      buttonStyle: AppButtonTheme.theme.style!.copyWith(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
