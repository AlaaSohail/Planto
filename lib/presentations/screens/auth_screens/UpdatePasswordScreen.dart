import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_care/presentations/widgets/MainButton.dart';

import '../../../controllers/cubit/user_cubit/user_cubit.dart';
import '../../../l10n/app_localizations.dart';
import '../../themes/app_button_theme.dart';
import '../../themes/app_theme.dart';
import '../../widgets/AuthTextField.dart';
import '../../widgets/ContainerIcons.dart';
import 'LoginScreen.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({
    super.key,
    this.resetToken,
  });

  final String? resetToken;

  @override
  State<UpdatePasswordScreen> createState() =>
      _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  bool isObscure = true;
  bool isObscure2 = true;

  final TextEditingController passwordController =
  TextEditingController();

  final TextEditingController confirmPasswordController =
  TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(
              builder: (_) => const LoginScreen(),
            ),
                (route) => false,
          );
        }

        if (state is ResetPasswordError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: AppTheme.plantCareAILogo(context),
            leading: AppTheme.backButton(context),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0).r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),

                  Text(
                    localization.updatePassword,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),

                  Center(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            localization.password.toUpperCase(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),

                          SizedBox(height: 12.h),

                          AuthTextField(
                            controller: passwordController,
                            hintText: localization.min8Characters,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: isObscure,
                            prefix: ContainerIcons(
                              icon: "assets/images/lock.png",
                            ),
                            suffix: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              splashFactory: NoSplash.splashFactory,
                              onTap: () {
                                setState(() {
                                  isObscure = !isObscure;
                                });
                              },
                              child: ContainerIcons(
                                icon: isObscure
                                    ? "assets/images/show.png"
                                    : "assets/images/close-eye.png",
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return localization.pleaseEnterYourPassword;
                              }

                              if (value.length < 8) {
                                return localization
                                    .passwordMustBeAtLeast8Characters;
                              }

                              return null;
                            },
                          ),

                          SizedBox(height: 12.h),

                          Text(
                            localization.confirmPassword.toUpperCase(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),

                          SizedBox(height: 12.h),

                          AuthTextField(
                            controller: confirmPasswordController,
                            hintText: localization.confirmPasswordHint,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: isObscure2,
                            prefix: ContainerIcons(
                              icon: "assets/images/lock.png",
                            ),
                            suffix: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              splashFactory: NoSplash.splashFactory,
                              onTap: () {
                                setState(() {
                                  isObscure2 = !isObscure2;
                                });
                              },
                              child: ContainerIcons(
                                icon: isObscure2
                                    ? "assets/images/show.png"
                                    : "assets/images/close-eye.png",
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return localization
                                    .pleaseEnterYourPassword;
                              }

                              if (value.length < 8) {
                                return localization
                                    .passwordMustBeAtLeast8Characters;
                              }

                              if (value != passwordController.text) {
                                return localization.passwordsDoNotMatch;
                              }

                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  MainButton(
                    content: localization.update,
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      final resetToken = widget.resetToken;

                      if (resetToken == null || resetToken.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              localization.invalidResetToken,
                            ),
                          ),
                        );
                        return;
                      }

                      context.read<UserCubit>().resetPassword(
                        resetToken,
                        passwordController.text.trim(),
                      );
                    },
                    textStyle:
                    Theme.of(context).textTheme.headlineSmall,
                    buttonStyle:
                    AppButtonTheme.theme.style!.copyWith(),
                    mainAxisSize: MainAxisSize.max,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}